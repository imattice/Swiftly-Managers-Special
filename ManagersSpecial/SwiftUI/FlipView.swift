//
//  FlipView.swift
//  ManagersSpecial
//
//  Created by Ike Mattice on 5/30/21.
//

import SwiftUI

///A view that contains a front and back view that can be rotated using an animation block
struct FlipView<Front: View, Back: View>: View {
    ///Tracks if the view is flipped
    var isFlipped: Bool
    ///The view shown when the view is not flipped
    var front: () -> Front
    ///The view shown when the view is flipped
    var back: () -> Back
    
    var body: some View {
        ZStack {
            front()
                .rotation3DEffect(.degrees(isFlipped == true ? 180 : 0), axis: (x: 0, y: 1, z: 0))
                .opacity(isFlipped == true ? 0 : 1)
                .accessibility(hidden: isFlipped == true)

            back()
                .rotation3DEffect(.degrees(isFlipped == true ? 0 : -180), axis: (x: 0, y: 1, z: 0))
                .opacity(isFlipped == true ? 1 : -1)
                .accessibility(hidden: isFlipped == false)
        }
    }
    
    init(isFlipped: Bool = false, @ViewBuilder front: @escaping () -> Front, @ViewBuilder back: @escaping () -> Back) {
        self.isFlipped = isFlipped
        self.front = front
        self.back = back
    }
}

struct FlipView_Previews: PreviewProvider {
    static var previews: some View {
        FlipView(front: {
            Text("Front")
                .frame(width: 200, height: 200)
                .background(Color.blue)
        },
        back: {
            Text("Front")
                .frame(width: 200, height: 200)
                .background(Color.green)
        })
    }
}
