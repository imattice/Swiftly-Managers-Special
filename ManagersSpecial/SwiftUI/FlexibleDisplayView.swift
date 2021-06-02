//
//  FlexibleDisplayView.swift
//  ManagersSpecial
//
//  Created by Ike Mattice on 5/28/21.
//

import SwiftUI

///A view for showing a collection of views in a continuous row that wraps overflow content
struct FlexibleDisplayView<Data: Collection, Content: View>: View where Data.Element: Hashable {
    ///A variable that keeps track of the available row width
    @State var availableWidth: CGFloat
    ///Contains the sizes of each element in the view
    @State var elementsSize: [Data.Element: CGSize] = [:]
    ///The data to be displayed
    let data: Data
    ///The spacing between each view
    let spacing: CGFloat = 8
    ///The alignment of each view
    let alignment: HorizontalAlignment = .center
    ///The view the element will be displayed as
    let content: (Data.Element) -> Content

  var body : some View {
    VStack(alignment: alignment, spacing: spacing) {
      ForEach(computeRows(), id: \.self) { rowElements in
        HStack(spacing: spacing) {
          ForEach(rowElements, id: \.self) { element in
            content(element)
              .fixedSize()
              .readSize { size in
                elementsSize[element] = size
              }
          }
        }
      }
    }
  }

    ///Computes the sizes of each row
  func computeRows() -> [[Data.Element]] {
    var rows: [[Data.Element]] = [[]]
    var currentRow = 0
    var remainingWidth = availableWidth

    for element in data {
      let elementSize = elementsSize[element, default: CGSize(width: availableWidth, height: 1)]

      if remainingWidth - (elementSize.width + spacing) >= 0 {
        rows[currentRow].append(element)
      } else {
        currentRow = currentRow + 1
        rows.append([element])
        remainingWidth = availableWidth
      }

      remainingWidth = remainingWidth - (elementSize.width + spacing)
    }

    return rows
  }
}

//struct FlexibleDisplayView_Previews: PreviewProvider {
//    static var previews: some View {
//        FlexibleDisplayView(availableWidth: 300, data: [Special(imageURL: "", displayName: "test product", originalPrice: "7.00", price: "6.00", viewSize: (height:8, width: 8))]) { special in
//            SpecialCard(viewStyle: ViewStyle(viewSize: CGSize(width: 4, height: 4), canvasUnit: 16))
//                .environmentObject(special)
//        }
//    }
//}
//
//
struct FlexibleDisplayView_Previews: PreviewProvider {
    
    static var previews: some View {
        FlexibleDisplayView(availableWidth: 300,
                            data: [
                                Special(imageURL: "https://raw.githubusercontent.com/Swiftly-Systems/code-exercise-ios/master/images/J.png", displayName: "test product", originalPrice: "7.00", price: "6.00", viewSize: (height:16, width: 16)),
                                Special(imageURL: "https://raw.githubusercontent.com/Swiftly-Systems/code-exercise-ios/master/images/J.png", displayName: "test product", originalPrice: "7.00", price: "6.00", viewSize: (height:8, width: 8)),
                                Special(imageURL: "https://raw.githubusercontent.com/Swiftly-Systems/code-exercise-ios/master/images/J.png", displayName: "test product", originalPrice: "7.00", price: "6.00", viewSize: (height:8, width: 8)),
                                Special(imageURL: "https://raw.githubusercontent.com/Swiftly-Systems/code-exercise-ios/master/images/J.png", displayName: "test product", originalPrice: "7.00", price: "6.00", viewSize: (height:8, width: 8)),
                                Special(imageURL: "https://raw.githubusercontent.com/Swiftly-Systems/code-exercise-ios/master/images/J.png", displayName: "test product", originalPrice: "7.00", price: "6.00", viewSize: (height:5, width: 14)),
                                Special(imageURL: "https://raw.githubusercontent.com/Swiftly-Systems/code-exercise-ios/master/images/J.png", displayName: "test product", originalPrice: "7.00", price: "6.00", viewSize: (height:4, width: 4)),
                                Special(imageURL: "https://raw.githubusercontent.com/Swiftly-Systems/code-exercise-ios/master/images/J.png", displayName: "test product", originalPrice: "7.00", price: "6.00", viewSize: (height:4, width: 4)),
                                Special(imageURL: "https://raw.githubusercontent.com/Swiftly-Systems/code-exercise-ios/master/images/J.png", displayName: "test product", originalPrice: "7.00", price: "6.00", viewSize: (height:4, width: 4)),
                                Special(imageURL: "https://raw.githubusercontent.com/Swiftly-Systems/code-exercise-ios/master/images/J.png", displayName: "test product", originalPrice: "7.00", price: "6.00", viewSize: (height:4, width: 4)),
                            ])
        {
            SpecialCard(viewStyle: ViewStyle(viewSize: CGSize(width: $0.viewWidth, height: $0.viewHeight), canvasUnit: 16))
                .border(Color.black)
                .environmentObject($0)
                .frame(
                    width: 16*CGFloat($0.viewWidth),
                    height: 16*CGFloat($0.viewHeight))
        }
        .frame(width: 300, height: 400)
    }
}
