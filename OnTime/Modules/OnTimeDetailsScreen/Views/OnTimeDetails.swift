//
//  OnTimeDetails.swift
//  OnTime
//
//  Created by Zahid Shabbir on 22/09/2023.
import SwiftUI
struct OnTimeDetailsView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var isNavigationActiveDetailView: Bool = false
    var onTime: OnTimeProtocol
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                OnTimeDetailsHeaderView(onTimeName: onTime.name ?? "", onClose: {
                    self.presentationMode.wrappedValue.dismiss()
                }).padding()
                HStack(spacing: 0) {
                    OnTimeDetailImageView(width: 255, height: 245, image: onTime.image ?? "")
                    ActivityCardView(onTime: onTime as! OnTime, onClose: {
                        self.isNavigationActiveDetailView = true
                        self.presentationMode.wrappedValue.dismiss()
                        
                    })
                }
                .padding(.leading)
            }
//            NavigationLink(destination: router.makeDescriptionView(), isActive: $isNavigationActiveDetailView) {
//                               EmptyView()
//            }
//            .hidden()
        }.navigationViewStyle(StackNavigationViewStyle())
        .navigationBarBackButtonHidden(true)


    }
}

struct OnTimeDetails_Previews: PreviewProvider {
    static var previews: some View {
        OnTimeDetailsView(onTime: dummyOnTime)
            .previewInterfaceOrientation(.landscapeRight)
    }
}
let dummyOnTime = OnTime(id: nil, schedule: nil, name: "Go to the dentist", image: "https://images.unsplash.com/photo-1685728399140-5650bbcfc015?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=3160&q=80")
