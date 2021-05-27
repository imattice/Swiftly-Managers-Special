//
//  Special.swift
//  ManagersSpecial
//
//  Created by Ike Mattice on 5/27/21.
//

import Foundation

///An object representing data for a specal offer
struct Special: Codable {
    let id: String = UUID().uuidString
    let displayName: String
    let originalPrice: String
    let price: String
}
