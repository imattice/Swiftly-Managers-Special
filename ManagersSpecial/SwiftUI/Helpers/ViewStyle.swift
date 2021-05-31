//
//  ViewStyle.swift
//  ManagersSpecial
//
//  Created by Ike Mattice on 5/30/21.
//

import CoreGraphics

///Indicates the type of view to show a particular special
enum ViewStyle {
    case smallImage, tower, long, normal
    
    init(viewSize: CGSize, canvasUnit: CGFloat) {
        
        if  (viewSize.width <= canvasUnit / 4) && (viewSize.height <= canvasUnit / 4)  {
            self = .smallImage
        }
        
        else if viewSize.width <= canvasUnit / 4 {
            self = .tower
        }
        
        else if viewSize.height <= canvasUnit / 4 {
            self = .long
        }
        
        else { self = .normal }
    }
}
