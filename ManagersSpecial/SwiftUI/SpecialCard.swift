//
//  SpecialCard.swift
//  ManagersSpecial
//
//  Created by Ike Mattice on 5/27/21.
//

import SwiftUI

///A card view used to display a Special
struct SpecialCard: View {
    ///The Special object to be displayed
    @EnvironmentObject var special: Special
    ///The view style that would best fit the Special being presented
    @State var viewStyle: ViewStyle
    
    var body: some View {
        GeometryReader { geometry in
            Group {
                switch viewStyle {
                case .smallImage:
                    FlipCard()
                case .long:
                    LongCard()
                case .tower:
                    TowerCard()
                default:
                    DefaultCard(geometry: geometry.size)
                }
            }
            .background(Color.white)
            .cornerRadius(20)
        }
    }
}

///A defaut view that fits most size cases
struct DefaultCard: View {
    ///The Special object to be displayed
    @EnvironmentObject var special: Special
    ///Contains the intended size of the view to calculate the size of the internal components
    @State var geometry: CGSize

    var body: some View {
        VStack {
            HStack {
                AsyncImage(url: special.imageURL)
                    .frame(minWidth: geometry.width / 6,
                           idealWidth: geometry.width / 4,
                           maxWidth: geometry.width / 2,
                           minHeight: geometry.width / 6,
                           idealHeight: geometry.width / 4,
                           maxHeight: geometry.width / 2,
                           alignment: .center)
                    .layoutPriority(90)
                    .aspectRatio(contentMode: .fit)
                Spacer()
                PriceDisplay()
                .frame(minWidth: geometry.width / 6,
                       idealWidth: geometry.width / 4,
                       maxWidth: geometry.width / 2,
                       minHeight: geometry.width / 6,
                       idealHeight: geometry.width / 4,
                       maxHeight: geometry.width / 2,
                       alignment: .center)
                .layoutPriority(100)
            }
            Spacer()
            Text(special.displayName)
                .padding()
                .font(.title2)
                .layoutPriority(95)
                .minimumScaleFactor(0.6)
                .multilineTextAlignment(.center)
        }
        .padding(8)
    }
}

///A card for Special size cases that are taller than they are long
struct TowerCard: View {
    ///The Special object to be displayed
    @EnvironmentObject var special: Special

    var body: some View {
        VStack {
            AsyncImage(url: special.imageURL)
                .aspectRatio(contentMode: .fit)
            Spacer()
            PriceDisplay()
        }
        .padding(8)
    }

}

///A card for Special size cases that are longer than they are tall
struct LongCard: View {
    ///The Special object to be displayed
    @EnvironmentObject var special: Special
    
    var body: some View {
        HStack(alignment: .center) {
            AsyncImage(url: special.imageURL)
                .aspectRatio(contentMode: .fit)
            Spacer()
            PriceDisplay()
            .padding()
        }
        .padding(8)
    }
}

///A card for small Special cases that only contain an image and pricing information
struct FlipCard: View {
    ///The Special object to be displayed
    @EnvironmentObject var special: Special
    ///Tracks if the card is currently in a  flipped state
    @State private var isFlipped = false

    var body: some View {
        FlipView(isFlipped: isFlipped) {
            AsyncImage(url: special.imageURL)
                .aspectRatio(contentMode: .fit)
        } back: {
            PriceDisplay()
        }
        .animation(.linear)
            .onTapGesture {
                self.isFlipped.toggle()
            }
        .padding()

    }
}

///Displays the original price and the current price in a vertically stacked view
struct PriceDisplay: View {
    ///The Special object to be displayed
    @EnvironmentObject var special: Special
    
    var body: some View {
        VStack {
            Text("$\(special.originalPrice)")
                .strikethrough()
                .bold()
                .foregroundColor(.gray)
                .minimumScaleFactor(0.5)
                .lineLimit(1)
            Text("$\(special.price)")
                .bold()
                .foregroundColor(.green)
                .minimumScaleFactor(0.5)
                .lineLimit(1)
        }
    }
}

struct SpecialCard_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SpecialCard(viewStyle: ViewStyle(viewSize: CGSize(width: 16, height: 16), canvasUnit: 16))
                .environmentObject(Special(imageURL: "https://raw.githubusercontent.com/Swiftly-Systems/code-exercise-ios/master/images/K.png", displayName: "Kikkoman Less Sodium Soy Sauce", originalPrice: "2.00", price: "1.00", viewSize: (height: 16, width:16)))
                .frame(width: 500, height: 500)
                .previewDisplayName("Default view")
            SpecialCard(viewStyle: ViewStyle(viewSize: CGSize(width: 4, height: 4), canvasUnit: 16))
                .environmentObject(Special(imageURL: "https://raw.githubusercontent.com/Swiftly-Systems/code-exercise-ios/master/images/K.png", displayName: "Kikkoman Less Sodium Soy Sauce", originalPrice: "2.00", price: "1.00", viewSize: (height: 4, width:4)))
                .frame(width: 300, height: 300)
                .previewDisplayName("Small Flip View")
            SpecialCard(viewStyle: ViewStyle(viewSize: CGSize(width: 4, height: 10), canvasUnit: 16))
                .environmentObject(Special(imageURL: "https://raw.githubusercontent.com/Swiftly-Systems/code-exercise-ios/master/images/K.png", displayName: "Kikkoman Less Sodium Soy Sauce", originalPrice: "2.00", price: "1.00", viewSize: (height: 10, width:5)))
                .frame(width: 300, height: 500)
                .previewDisplayName("Tower View")
            SpecialCard(viewStyle: ViewStyle(viewSize: CGSize(width: 10, height: 4), canvasUnit: 16))
                .environmentObject(Special(imageURL: "https://raw.githubusercontent.com/Swiftly-Systems/code-exercise-ios/master/images/J.png", displayName: "Kikkoman Less Sodium Soy Sauce", originalPrice: "2.00", price: "1.00", viewSize: (height:5, width:10)))
                .frame(width: 500, height: 300)
                .previewDisplayName("Long View")
        }
            .previewLayout(.sizeThatFits)
    }
}
