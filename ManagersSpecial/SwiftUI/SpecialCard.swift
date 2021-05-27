//
//  SpecialCard.swift
//  ManagersSpecial
//
//  Created by Ike Mattice on 5/27/21.
//

import SwiftUI

struct SpecialCard: View {
    @State var special: Special
    
    var body: some View {
        VStack {
            HStack {
                AsyncImage(url: special.imageURL)
                    .frame(width: 100, height: 100, alignment: .center)
                Spacer()
                VStack {
                    Text("$\(special.originalPrice)")
                        .strikethrough()
                        .bold()
                        .foregroundColor(.gray)
                    Text("$\(special.price)")
                        .bold()
                        .foregroundColor(.green)
                    
                }
            }
            Text(special.displayName)
        }
        .cornerRadius(10)
        .padding()
    }
}

struct SpecialCard_Previews: PreviewProvider {
    static var previews: some View {
        SpecialCard(special: Special(imageURL: "https://raw.githubusercontent.com/Swiftly-Systems/code-exercise-ios/master/images/K.png", displayName: "Kikkoman Less Sodium Soy Sauce", originalPrice: "2.00", price: "1.00", viewSize: (height: 8, width:8)))
            .previewLayout(.sizeThatFits)
    }
}
