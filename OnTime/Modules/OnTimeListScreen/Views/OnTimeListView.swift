//
//  OnTimeListView.swift
//  OnTime
//
//  Created by Zahid Shabbir on 22/09/2023.
//

import SwiftUI

struct OnTimeListView: View {
    @ObservedObject var onTimeListPresenter: OnTimeListPresenter
    @State var selectedOnTime: OnTime
    @State var isNavigationActive: Bool = false
    @State var selectedOnTimeName: String = ""

    

    var body: some View {
        NavigationView {
            MainContent(onTimeListPresenter: onTimeListPresenter,
                        selectedOnTime: $selectedOnTime,
                        isNavigationActive: $isNavigationActive,
                        selectedOnTimeName: $selectedOnTimeName)
            .backgroundPattern()
                .onAppear {
                    onTimeListPresenter.loadOnTimes()
                }
                .onReceive(onTimeListPresenter.$selectedName) { selectedName in
                    self.selectedOnTimeName = selectedName
                }

        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct MainContent: View {
    @ObservedObject var onTimeListPresenter: OnTimeListPresenter
    @Binding var selectedOnTime: OnTime
    @Binding var isNavigationActive: Bool
    @Binding var selectedOnTimeName: String
    

    var body: some View {
        VStack {
            OnTimeHeader(title: Constants.onTimeListTitle, time: Utility.currentTime, icon: Constants.Images.settingsBtn)

            if !onTimeListPresenter.onTime.isEmpty {
                OnTimesCollectionView(onTimeListPresenter: onTimeListPresenter,
                                        selectedOnTime: $selectedOnTime,
                                        isNavigationActive: $isNavigationActive,
                                        selectedOnTimeName: selectedOnTimeName
                )
            } else {
                LoadingView()
            }

            Text(selectedOnTimeName)
                .fontStyle(RortyFont.title2)
            NavigationLink(destination: onTimeListPresenter.makeDetailsView(for: selectedOnTime), isActive: $isNavigationActive) {
                               EmptyView()
            }
            .hidden()
        }
    }
}
struct OnTimeList_Previews: PreviewProvider {
        static var previews: some View {
            let interactor = OnTimeListInteractor(apiService: APIOnTimeService(networkService: AlamofireService()))
            let presenter = OnTimeListPresenter(interactor: interactor, router: OnTimeListRouter())
            OnTimeListView(onTimeListPresenter: presenter, selectedOnTime: dummyOnTime)
                .previewInterfaceOrientation(.landscapeRight)
        }
}
