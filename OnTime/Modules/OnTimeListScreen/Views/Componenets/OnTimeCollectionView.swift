//
//  OnTimesCollectionView.swift
//  OnTime
//
//  Created by Zahid Shabbir on 22/09/2023.
//

import SwiftUI

struct OnTimesCollectionView: View {
    @ObservedObject var onTimeListPresenter: OnTimeListPresenter
    @Binding var selectedOnTime: OnTime
    @Binding var isNavigationActive: Bool
    @State var selectedOnTimeName: String = ""

    var body: some View {
        CollectionView(onTime: $onTimeListPresenter.onTime) { selected in
            self.selectedOnTime = selected
            self.isNavigationActive = true
        } onCellChange: { selected in
            selectedOnTimeName = selected.name ?? "No Item"
        }
    }
}
