//
//  ManagerSpecial.swift
//  ManagersSpecial
//
//  Created by Ike Mattice on 5/27/21.
//

import Foundation

///A Decodable object to represent the API response
struct APIResponse: Decodable {
    ///The number of units that can fit on the width of the device
    let canvasUnit: Int
    ///Contains all specials currently available
    let specials: [Special]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.canvasUnit = try container.decode(Int.self, forKey: .canvasUnit)
        self.specials   = try container.decode([Special].self, forKey: .managerSpecials)
    }
    
    enum CodingKeys: CodingKey {
        case canvasUnit, managerSpecials
    }
}


