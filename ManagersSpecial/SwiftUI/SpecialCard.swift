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
        GeometryReader { geometry in
        VStack {
            HStack {
                AsyncImage(url: special.imageURL)
                    .frame(minWidth: geometry.frame(in: .local).width / 6,
                           idealWidth: geometry.frame(in: .local).width / 4,
                           maxWidth: geometry.frame(in: .local).width / 2,
                           minHeight: geometry.frame(in: .local).width / 6,
                           idealHeight: geometry.frame(in: .local).width / 4,
                           maxHeight: geometry.frame(in: .local).width / 2,
                           alignment: .center)
                    .layoutPriority(90)
                    .aspectRatio(contentMode: .fill)
                Spacer()
                VStack {
                    Text("$\(special.originalPrice)")
                        .strikethrough()
                        .bold()
                        .foregroundColor(.gray)
                        .minimumScaleFactor(0.9)
                    Text("$\(special.price)")
                        .bold()
                        .foregroundColor(.green)
                        .minimumScaleFactor(0.9)
                }
                .frame(minWidth: geometry.frame(in: .local).width / 6,
                       idealWidth: geometry.frame(in: .local).width / 4,
                       maxWidth: geometry.frame(in: .local).width / 2,
                       minHeight: geometry.frame(in: .local).width / 6,
                       idealHeight: geometry.frame(in: .local).width / 4,
                       maxHeight: geometry.frame(in: .local).width / 2,
                       alignment: .center)
                .layoutPriority(90)
            }
            Spacer()
                .layoutPriority(0)
            Text(special.displayName)
                .padding()
                .layoutPriority(100)
                .minimumScaleFactor(0.75)
                .multilineTextAlignment(.center)
        }
        .cornerRadius(10)
        .padding()
        }
    }
}

struct SpecialCard_Previews: PreviewProvider {
    static var previews: some View {
        SpecialCard(special: Special(imageURL: "https://raw.githubusercontent.com/Swiftly-Systems/code-exercise-ios/master/images/K.png", displayName: "Kikkoman Less Sodium Soy Sauce", originalPrice: "2.00", price: "1.00", viewSize: (height: 8, width:8)))
            .previewLayout(.sizeThatFits)
    }
}
