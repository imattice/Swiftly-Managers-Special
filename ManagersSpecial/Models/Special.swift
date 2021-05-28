//
//  Special.swift
//  ManagersSpecial
//
//  Created by Ike Mattice on 5/27/21.
//

import Foundation

///An object representing data for a specal offer
struct Special: Decodable, Identifiable {
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
    internal
    init(imageURL: String, displayName: String, originalPrice: String, price: String, viewSize: (height: Int, width: Int)) {
        self.imageURL = imageURL
        self.displayName = displayName
        self.originalPrice = originalPrice
        self.price = price
        self.viewSize = viewSize
    }
    
    enum CodingKeys: CodingKey {
        case imageUrl, width, height, display_name, original_price, price
    }
}
