//
//  ContentView.swift
//  ManagersSpecial
//
//  Created by Ike Mattice on 5/27/21.
//

import SwiftUI
import Combine
//TODO: ✅ - Fetch data from API
//TODO: - Update data periodically/manually

//TODO: ✅ - Create card view to display specials
//TODO: - Display products using CanvasUnit sizing parameters
    //TODO: - Initialize SpecialCard View with canvas units?
    //TODO: - Create canvas on the super view and fit cards onto the canvas?
//TODO: - Scroll to see all Specials
//TODO: - Display cards that do not fit in the canvas on a new line
//TODO: - Center cards
//TODO: - Add Readme file

struct ManagersSpecialView: View {
    @State var networkManager: NetworkManager = NetworkManager()
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                ScrollView {
                    ForEach(networkManager.specials) { special in
                        Text(special.displayName)
                    }
                }
                .navigationTitle("Manager's Special")
            }
        }
    }
}

struct ManagersSpecialView_Previews: PreviewProvider {
    static var previews: some View {
        ManagersSpecialView()
    }
}
