//
//  Special.swift
//  ManagersSpecial
//
//  Created by Ike Mattice on 5/27/21.
//

import Foundation

///An object representing data for a specal offer
class Special: Decodable, Identifiable, ObservableObject {
    ///The id for this  object
    let id: String = UUID().uuidString
    ///The url for the image for this object
    let imageURL: String
    ///The display name of the object
    let displayName: String
    ///The original price for the object
    let originalPrice: String
    ///The discounted price for the object
    let price: String
    ///The ideal height for the object, in canvas units
    let viewHeight: Int
    ///The ideal width for the object, in canvas units
    let viewWidth: Int
            
    required
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.imageURL = try container.decode(String.self, forKey: .imageUrl)
        self.displayName = try container.decode(String.self, forKey: .display_name)
        self.originalPrice = try container.decode(String.self, forKey: .original_price)
        self.price  = try container.decode(String.self, forKey: .price)
        self.viewHeight = try container.decode(Int.self, forKey: .height)
        self.viewWidth = try container.decode(Int.self, forKey: .width)
    }
    internal
    init(imageURL: String, displayName: String, originalPrice: String, price: String, viewSize: (height: Int, width: Int)) {
        self.imageURL = imageURL
        self.displayName = displayName
        self.originalPrice = originalPrice
        self.price = price
        self.viewHeight = viewSize.height
        self.viewWidth = viewSize.width
    }
    
    enum CodingKeys: CodingKey {
        case imageUrl, width, height, display_name, original_price, price
    }
}

extension Special: Hashable, Equatable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Special, rhs: Special) -> Bool {
        return lhs.id == rhs.id
    }
}
