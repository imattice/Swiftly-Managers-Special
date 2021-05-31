//
//  ContentView.swift
//  ManagersSpecial
//
//  Created by Ike Mattice on 5/27/21.
//

import SwiftUI

struct ManagersSpecialView: View {
    @ObservedObject var networkManager: NetworkManager = NetworkManager()
    let scrollViewPadding: CGFloat = 8
    
    var body: some View {
            NavigationView {
                GeometryReader { geometry in
                    //Calculate the points for the width of each canvas unit
                    let canvasUnit = (geometry.size.width - (scrollViewPadding*2)) / CGFloat(networkManager.canvasUnit ?? 1)
                    
                    ScrollView {
                        //Using the GeometryReader value as the availableWidth does not provide the screen size in time for the FlexibleDisplayView to calculate the row sizes accurately
                        FlexibleDisplayView(availableWidth: UIScreen.main.bounds.width, data: networkManager.specials) {
                            SpecialCard(viewStyle: ViewStyle(viewSize: CGSize(width: $0.viewWidth, height: $0.viewHeight), canvasUnit: canvasUnit))
                                .environmentObject($0)
                                .frame(
                                    width: canvasUnit*CGFloat($0.viewWidth),
                                    height: canvasUnit*CGFloat($0.viewHeight))
                        }
                    }
                    .navigationTitle("Manager's Special")
                    .navigationBarTitleDisplayMode(.inline)
                    .padding(scrollViewPadding)
            }
            .background(Color.lightGray.edgesIgnoringSafeArea(.all))

        }

    }
}

struct ManagersSpecialView_Previews: PreviewProvider {
    static var previews: some View {
        ManagersSpecialView()
    }
}
