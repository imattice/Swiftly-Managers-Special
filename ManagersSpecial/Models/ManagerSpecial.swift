//
//  ManagerSpecial.swift
//  ManagersSpecial
//
//  Created by Ike Mattice on 5/27/21.
//

import Foundation

///An object descirbing View parameters
struct ManagerSpecial: Codable {
    ///The number of units that can fit on the width of the device
    let canvasSize: Int
    ///Contains all specials currently available
    let specials: [Special]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.canvasSize = try container.decode(Int.self, forKey: .canvasUnit)
        self.specials   = try container.decode([Special].self, forKey: .managerSpecials)
    }
    
    ///Fetch data for a ManagerSpecial object from the api endpoint
    static
    func fetchFromAPI(endpoint: String = "https://raw.githubusercontent.com/Swiftly-Systems/code-exercise-ios/master/backup",  completion: @escaping (ManagerSpecial) -> ()) {
       
        guard let url = URL(string: endpoint)
        else { print("invalid endpoint: \(endpoint)"); return  }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { print("invalid data returned from data task"); return }
            
              do {
                let managerSpecial = try JSONDecoder().decode(ManagerSpecial.self, from: data)
                DispatchQueue.main.async {
                    completion(managerSpecial)
                 }
              } catch {
                print("JSONSerialization error:", error)
            }
            
        }.resume()
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(canvasSize, forKey: .canvasUnit)
        try container.encode(specials, forKey: .managerSpecials)
    }
    
    enum CodingKeys: CodingKey {
        case canvasUnit, managerSpecials
    }
}


