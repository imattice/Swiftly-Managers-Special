//
//  FlexibleDisplayView.swift
//  ManagersSpecial
//
//  Created by Ike Mattice on 5/28/21.
//

import SwiftUI

struct FlexibleDisplayView<Data: Collection, Content: View>: View where Data.Element: Hashable {
  let availableWidth: CGFloat = 300
  let data: Data
  let spacing: CGFloat = 8
    let alignment: HorizontalAlignment = .center
  let content: (Data.Element) -> Content
  @State var elementsSize: [Data.Element: CGSize] = [:]

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

struct FlexibleDisplayView_Previews: PreviewProvider {
    static var previews: some View {
        FlexibleDisplayView(data: [Special(imageURL: "", displayName: "test product", originalPrice: "7.00", price: "6.00", viewSize: (height:8, width: 8))]) { special in
            SpecialCard(special: special)
        }
    }
}
