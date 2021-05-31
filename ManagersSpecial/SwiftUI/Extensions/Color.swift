//
//  Color.swift
//  ManagersSpecial
//
//  Created by Ike Mattice on 5/30/21.
//

import SwiftUI

//A SwiftUI Color implementation of the systemGrey6 UIColor
extension Color {
    static let lightGray = Color(UIColor.systemGray6)
}

//This extension is used to set the background color of the NavigationController
extension UINavigationController {
    override open func viewDidLoad() {
        super.viewDidLoad()

    let standard = UINavigationBarAppearance()
    standard.backgroundColor = .systemGray6 //When you scroll or you have title (small one)

    let compact = UINavigationBarAppearance()
    compact.backgroundColor = .systemGray6 //compact-height

    let scrollEdge = UINavigationBarAppearance()
    scrollEdge.backgroundColor = .systemGray6 //When you have large title

    navigationBar.standardAppearance = standard
    navigationBar.compactAppearance = compact
    navigationBar.scrollEdgeAppearance = scrollEdge
 }
}
