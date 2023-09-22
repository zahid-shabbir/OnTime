//
//  CollectionView.swift
//  OnTime
//
//  Created by Zahid Shabbir on 03/06/2023.
//

import SwiftUI
import UIKit

struct CollectionView: UIViewRepresentable {

    @Binding var onTime: [OnTime]  // change to @Binding
    var didSelectItem: (OnTime) -> Void
    var onCellChange: (OnTime) -> Void

    func makeUIView(context: Context) -> UICollectionView {
        let layout = ScalingFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = context.coordinator
        collectionView.delegate = context.coordinator
        layout.delegate = context.coordinator
        collectionView.register(RedCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.decelerationRate = .fast

        context.coordinator.collectionView = collectionView  // save reference to the collection view in the coordinator

        return collectionView
    }

    func updateUIView(_ uiView: UICollectionView, context: Context) {
        // refresh the collection view when the data changes
        context.coordinator.collectionView?.reloadData()
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ScalingFlowLayoutDelegate {
        var parent: CollectionView

        weak var collectionView: UICollectionView?

        init(_ collectionView: CollectionView) {
            self.parent = collectionView
        }

        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return parent.onTime.count
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! RedCollectionViewCell
            cell.isCenter = indexPath.row == collectionView.centermostIndexPath()?.row

            let imageUlr = self.parent.onTime[indexPath.row].image ?? ""
            cell.imageView.downloads(from: imageUlr)
            // cell.imageView.clipsToBounds = true
            cell.imageView.contentMode = .scaleAspectFit
            cell.imageView.applyCornerRadius(15)

            // Set the border color and width
                cell.layer.borderColor = #colorLiteral(red: 0.1450980392, green: 0.2117647059, blue: 0.2745098039, alpha: 1)
            cell.layer.borderWidth  = 1.5
            cell.backgroundColor = .white
                // Set the shadow
                cell.layer.shadowColor = UIColor.black.cgColor
                cell.layer.shadowOffset = CGSize(width: 0, height: 1.0)  // the offset of the shadow (x,y)
                cell.layer.shadowOpacity = 0.5  // the transparency of the shadow
                cell.layer.shadowRadius = 4.0  // the blur radius of the shadow
                cell.layer.masksToBounds = false

            return cell
        }

        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                   // Call the closure with the selected onTime
                   let onTime = parent.onTime[indexPath.row]
                   parent.didSelectItem(onTime)
        }

        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            guard let collectionView = scrollView as? UICollectionView else { return }
            for cell in collectionView.visibleCells as! [RedCollectionViewCell] {
                guard let indexPath = collectionView.indexPath(for: cell) else { continue }
                cell.isCenter = (indexPath.row == collectionView.centermostIndexPath()?.row)
            }
        }

        func didChangeFocusTo(indexPath: IndexPath) {
                parent.onCellChange(parent.onTime[indexPath.row])
            }
    }
}

class ScalingFlowLayout: UICollectionViewFlowLayout {

    weak var delegate: ScalingFlowLayoutDelegate?

    let standardItemSize = CGSize(width: 155, height: 148)
    let centerItemSize = CGSize(width: 213, height: 204)

    override func prepare() {
        super.prepare()

        self.itemSize = standardItemSize
        let inset = max((collectionView!.bounds.width - itemSize.width) / 2, 0)
        self.sectionInset = UIEdgeInsets(
            top: 0,
            left: inset,
            bottom: 0,
            right: inset
        )
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)?.map { $0.copy() as! UICollectionViewLayoutAttributes }

        attributes?.forEach { attribute in
            let frame = attribute.frame
            let distance = abs(collectionView!.contentOffset.x + collectionView!.bounds.width / 2 - frame.midX)
            let scale: CGFloat

            if distance < collectionView!.bounds.width / 2 {
                scale = 1 - 0.2 * (distance / (collectionView!.bounds.width / 2))
            } else {
                scale = 0.8 - 0.2 * ((distance - collectionView!.bounds.width / 2) / (collectionView!.bounds.width / 2))
            }

            UIView.animate(withDuration: 0.5) {
                if attribute.indexPath.row == self.collectionView?.centermostIndexPath()?.row {
                    attribute.transform = CGAffineTransform(scaleX: scale * 1.1, y: scale * 1.1) // increase the scale for the center cell

                    self.delegate?.didChangeFocusTo(indexPath: attribute.indexPath)

                } else {
                    attribute.transform = CGAffineTransform(scaleX: scale, y: scale)
                }

            }
        }

        return attributes
    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}

class RedCollectionViewCell: UICollectionViewCell {
    var imageView: UIImageView!
    var isCenter: Bool = false {
        didSet {
            // self.backgroundColor = isCenter ? .red : .blue
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        imageView = UIImageView(frame: self.contentView.bounds)
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true

        self.contentView.addSubview(imageView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UICollectionView {
    func centermostIndexPath() -> IndexPath? {
        let centerPoint = CGPoint(x: bounds.size.width / 2 + contentOffset.x, y: bounds.size.height / 2 + contentOffset.y)
        return indexPathForItem(at: centerPoint)
    }
}

protocol ScalingFlowLayoutDelegate: AnyObject {
    func didChangeFocusTo(indexPath: IndexPath)
}
