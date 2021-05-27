//
//  Special.swift
//  ManagersSpecial
//
//  Created by Ike Mattice on 5/27/21.
//

import Foundation

///An object representing data for a specal offer
struct Special: Codable, Identifiable {
    let id: String = UUID().uuidString
    let imageURL: String
    let displayName: String
    let originalPrice: String
    let price: String
    let viewSize: (height: Int, width:Int)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.imageURL = try container.decode(String.self, forKey: .imageUrl)
        self.displayName = try container.decode(String.self, forKey: .display_name)
        self.originalPrice = try container.decode(String.self, forKey: .original_price)
        self.price  = try container.decode(String.self, forKey: .price)
        
        let height = try container.decode(Int.self, forKey: .height)
        let width = try container.decode(Int.self, forKey: .width)
        self.viewSize = (height: height, width: width)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(imageURL, forKey: .imageUrl)
        try container.encode(displayName, forKey: .display_name)
        try container.encode(originalPrice, forKey: .original_price)
        try container.encode(price, forKey: .price)
        try container.encode(viewSize.height, forKey: .height)
        try container.encode(viewSize.width, forKey: .width)
    }
    
    enum CodingKeys: CodingKey {
        case imageUrl, width, height, display_name, original_price, price
    }
}
