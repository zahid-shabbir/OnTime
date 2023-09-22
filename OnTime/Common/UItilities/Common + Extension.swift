//
//  Common + Extension.swift
//  OnTime
//
//  Created by Zahid Shabbir on 22/09/2023.
//

import Foundation
import UIKit

/// Typealias for a dictionary of parameters used in network requests.
typealias ParamsType = [String: Any]?
let imageBaseUrl = "https://image.tmdb.org/t/p/w92/"
/// Enum representing different HTTP methods.
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
    // ... add more cases as needed
}

/// Extension on SceneDelegate to load a view controller from a nib.

extension Data {
    /// Prints the data in a pretty JSON format.
    func printPretty() {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: self, options: .allowFragments)
            let jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
            print(String(data: jsonData, encoding: .utf8) ?? "Sorry cannot print Pretty :(")
        } catch _ {
            print("Sorry cannot printPretty :( it's not valid JSON data")
        }
    }
}

extension URL {
    /// Asynchronously downloads data from the URL.
    ///
    /// - Parameter completion: A closure to be called with the downloaded data, response, and error.
    func asyncDownload(completion: @escaping (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared
            .dataTask(with: self, completionHandler: completion)
            .resume()
    }
}

extension URLRequest {
    /// Asynchronously downloads data using the URLRequest.
    ///
    /// - Parameter completion: A closure to be called with the downloaded data, response, and error.
    func asyncDownload(completion: @escaping (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared
            .dataTask(with: self, completionHandler: completion)
            .resume()
    }
}

extension UIImageView {
    func download(from url: URL) {
        let imageCache = NSCache<NSString, UIImage>()
        let urlStringIs = url.absoluteString

        if let imageFromCache = imageCache.object(forKey: urlStringIs as NSString) {
            image = imageFromCache
            return
        }
        image = #imageLiteral(resourceName: "comingsoon")
        //        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in

            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async { [weak self] in
                self?.image = image
                imageCache.setObject(image, forKey: urlStringIs as NSString)
            }
        }.resume()
    }

    func downloads(from link: String) {
        guard let url = URL(string: link) else {
            image = #imageLiteral(resourceName: "comingsoon")
            return
        }
        download(from: url)
    }

    func changeImage(color: UIColor) {
        if let image = image {
            self.image = image.withRenderingMode(.alwaysTemplate)
            tintColor = color
        }
    }
}

extension UIImage {
    static let heartFillImage = UIImage(systemName: "heart.fill")?.withTintColor(.red, renderingMode: .alwaysOriginal)
    static let heartImage = UIImage(systemName: "heart")?.withTintColor(.lightGray, renderingMode: .alwaysOriginal)
}

extension UIView {
    func addGradient(colors: [UIColor], startPoint: CGPoint = CGPoint(x: 0.0, y: 0.0), endPoint: CGPoint = CGPoint(x: 1.0, y: 1.0)) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors.map(\.cgColor)
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        layer.insertSublayer(gradientLayer, at: 0)
    }

    func addShadow(color: UIColor = .black,
                   opacity: Float = 0.2,
                   offset: CGSize = CGSize(width: 0, height: 0),
                   radius: CGFloat = 10.0,
                   spread: CGFloat = 0.0) {
        let shadowPath = UIBezierPath(rect: bounds.insetBy(dx: -spread, dy: -spread))

        let shadowLayer = CAShapeLayer()
        shadowLayer.path = shadowPath.cgPath
        shadowLayer.fillColor = backgroundColor?.cgColor
        shadowLayer.shadowColor = color.cgColor
        shadowLayer.shadowOffset = offset
        shadowLayer.shadowOpacity = opacity
        shadowLayer.shadowRadius = radius

        layer.insertSublayer(shadowLayer, at: 0)
    }

    func dropShadow(color: UIColor = .black) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 1
        layer.cornerRadius = 6
        clipsToBounds = true
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }

    func applyCornerRadius(_ radius: CGFloat) {
        layer.cornerRadius = radius
        clipsToBounds = true
    }
}

protocol Injectable {
    associatedtype Dependency
    func inject(dependency: Dependency)
}

extension Injectable where Self: UIViewController {
    static func instantiate(with dependency: Dependency) -> Self {
        let viewController = Self(nibName: String(describing: Self.self), bundle: nil)
        viewController.inject(dependency: dependency)
        return viewController
    }
}

extension String {
    var isNotEmpty: Bool { !isEmpty }
    var trim: String { trimmingCharacters(in: .whitespacesAndNewlines) }
}

extension Bool {
    var isFalse: Bool { !self }
}

extension UITabBarItem {
    func setColorsForState(selected: UIColor, unselected: UIColor) {
        // Set the selected and unselected colors for the title
        setTitleTextAttributes([NSAttributedString.Key.foregroundColor: selected], for: .selected)
        setTitleTextAttributes([NSAttributedString.Key.foregroundColor: unselected], for: .normal)

        // Set the selected and unselected colors for the image
        if let image = image {
            self.image = image.withRenderingMode(.alwaysOriginal).withTintColor(unselected)
        }
        if let selectedImage = selectedImage {
            self.selectedImage = selectedImage.withRenderingMode(.alwaysOriginal).withTintColor(selected)
        }
    }
}

extension DecodingError {
    func handle() -> NetworkError {
        switch self {
        case let .dataCorrupted(context):
            print("Data corrupted: \(context.debugDescription)")
            print("Coding path: \(context.codingPath)")
            return NetworkError.parsingError
        case let .keyNotFound(key, context):
            print("Key '\(key.stringValue)' not found: \(context.debugDescription)")
            print("Coding path: \(context.codingPath)")
            return NetworkError.parsingError
        case let .typeMismatch(type, context):
            print("Type '\(type)' mismatch: \(context.debugDescription)")
            print("Coding path: \(context.codingPath)")
            return NetworkError.parsingError
        case let .valueNotFound(value, context):
            print("Value '\(value)' not found: \(context.debugDescription)")
            print("Coding path: \(context.codingPath)")
            return NetworkError.parsingError
        default:
            return NetworkError.unknownError(self)
        }
    }
}

protocol OnTimeProtocol {
    var id: String? { get }
    var schedule: Schedule? {get}
    var name: String? { get }
    var image: String? { get }
}
