//
//  Special.swift
//  ManagersSpecial
//
//  Created by Ike Mattice on 5/27/21.
//

import Foundation

///An object representing data for a specal offer
class Special: Decodable, Identifiable, ObservableObject {
    let id: String = UUID().uuidString
    let imageURL: String
    let displayName: String
    let originalPrice: String
    let price: String
    let viewHeight: Int
    let viewWidth: Int
    
    var viewStyle: ViewStyle {
        if  (viewWidth <= 5) && (viewHeight <= 5)  {
            return .smallImage
        }
        else if viewWidth <= 5 {
            return .tower
        }
        else if viewHeight <= 5 {
            return .long
        }
        else { return .normal }
    }
    
    enum ViewStyle {
        case smallImage, tower, long, normal
    }
        
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
