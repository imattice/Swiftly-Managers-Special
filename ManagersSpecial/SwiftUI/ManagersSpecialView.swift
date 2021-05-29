//
//  ContentView.swift
//  ManagersSpecial
//
//  Created by Ike Mattice on 5/27/21.
//

import SwiftUI
//import Combine
//TODO: ✅ - Fetch data from API
//TODO: - Update data periodically/manually

//TODO: ✅ - Create card view to display specials
//TODO: - Display products using CanvasUnit sizing parameters
    //TODO: - Initialize SpecialCard View with canvas units?
    //TODO: - Create canvas on the super view and fit cards onto the canvas?
//TODO: ✅ - Scroll to see all Specials
//TODO: ✅ - Display cards that do not fit in the canvas on a new line
//TODO: ✅ - Center cards
//TODO: - Add Readme file

struct ManagersSpecialView: View {
    @ObservedObject var networkManager: NetworkManager = NetworkManager()
    let scrollViewPadding: CGFloat = 8
    
    var body: some View {
        GeometryReader { geometry in
            let canvasUnit = (geometry.size.width - (scrollViewPadding*2)) / CGFloat(networkManager.canvasUnit ?? 1)
            NavigationView {
                ScrollView {
                    FlexibleDisplayView(data: networkManager.specials) {
                        SpecialCard(special: $0)
                        .frame(
                            width: canvasUnit*CGFloat($0.viewWidth),
                            height: canvasUnit*CGFloat($0.viewHeight))
                        .border(Color.black)

                    }
                }
                .navigationTitle("Manager's Special")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

struct ManagersSpecialView_Previews: PreviewProvider {
    static var previews: some View {
        ManagersSpecialView()
    }
}
