//
//  ContentView.swift
//  ManagersSpecial
//
//  Created by Ike Mattice on 5/27/21.
//

import SwiftUI

struct ManagersSpecialView: View {
    @ObservedObject var networkManager: NetworkManager = NetworkManager()
    let refreshTimer = Timer.publish(every: 15.0, tolerance: 0.5, on: .main, in: .common).autoconnect()
    let scrollViewPadding: CGFloat = 8
    
    var body: some View {
            NavigationView {
                GeometryReader { geometry in
                    //Calculate the points for the width of each canvas unit
                    let canvasUnit = (geometry.size.width - (scrollViewPadding*2)) / CGFloat(networkManager.canvasUnit ?? 1)
                    
                    ScrollView {
                        PullToRefresh(coordinateSpaceName: "pullToRefresh") {
                            networkManager.refresh()
                        }
                        //Using the GeometryReader value as the availableWidth does not provide the screen size in time for the FlexibleDisplayView to calculate the row sizes accurately
                        FlexibleDisplayView(availableWidth: UIScreen.main.bounds.width, data: networkManager.specials) {
                            SpecialCard(viewStyle: ViewStyle(viewSize: CGSize(width: $0.viewWidth, height: $0.viewHeight), canvasUnit: canvasUnit))
                                .environmentObject($0)
                                .frame(
                                    width: canvasUnit*CGFloat($0.viewWidth),
                                    height: canvasUnit*CGFloat($0.viewHeight))
                        }
                    }
                    .coordinateSpace(name: "pullToRefresh")
                    .navigationTitle("Manager's Special")
                    .navigationBarTitleDisplayMode(.inline)
                    .padding(scrollViewPadding)
            }
                .onReceive(refreshTimer) { _ in 
                    networkManager.refresh()
                }
            .background(Color.lightGray.edgesIgnoringSafeArea(.all))
        }
            .navigationViewStyle(StackNavigationViewStyle())
    }
        
    func cancelAutomaticRefresh() {
        refreshTimer.upstream.connect().cancel()
    }
}

struct ManagersSpecialView_Previews: PreviewProvider {
    static var previews: some View {
        ManagersSpecialView()
    }
}
