//
//  NetworkManager.swift
//  ManagersSpecial
//
//  Created by Ike Mattice on 5/28/21.
//

import Foundation
import Combine

///A class for managing the network call and updating data in the UI
class NetworkManager: ObservableObject {
    ///Contains all specials currently available
    @Published
    var specials = [Special]()
    ///The number of units that can fit on the width of the device
    @Published
    var canvasUnit: Int? = nil
    
    init(endpoint: String = "https://raw.githubusercontent.com/Swiftly-Systems/code-exercise-ios/master/backup", completion: (()->())? = nil) {
        fetch(from: endpoint)
    }
    
    ///Update NetworkManager properties from the specified endpoint
    func fetch(from endpoint: String = "https://raw.githubusercontent.com/Swiftly-Systems/code-exercise-ios/master/backup", completion: (()->())? = nil) {
        guard let url = URL(string: endpoint) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data,
            let managerSpecial = try? JSONDecoder().decode(APIResponse.self, from: data)
            else { print("invalid data returned from data task"); return }
            
            DispatchQueue.main.async {
                self.specials = managerSpecial.specials
                self.canvasUnit =  managerSpecial.canvasUnit
                if let completion = completion {
                    completion()
                }
            }
        }.resume()
    }
    
    func refresh() {
        print("will fetch new data")
        self.fetch() {
            print("new data fetched")
        }
    }
}
