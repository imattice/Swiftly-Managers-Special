//
//  PullToRefresh.swift
//  ManagersSpecial
//
//  Created by Ike Mattice on 6/1/21.
//

import SwiftUI

struct PullToRefresh: View {
    
    var coordinateSpaceName: String
    var onRefresh: ()->Void
    
    @State var needRefresh: Bool = false
    
    var body: some View {
        GeometryReader { geo in
            if (geo.frame(in: .named(coordinateSpaceName)).midY > 50) {
                Spacer()
                    .onAppear {
                        needRefresh = true
                    }
            } else if (geo.frame(in: .named(coordinateSpaceName)).maxY < 10) {
                Spacer()
                    .onAppear {
                        if needRefresh {
                            needRefresh = false
                            onRefresh()
                        }
                    }
            }
            HStack {
                Spacer()
                if needRefresh {
                    ProgressView()
                } else {
                    Text("⬇️")
                }
                Spacer()
            }
        }.padding(.top, -50)
    }
}

struct PullToRefresh_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
        PullToRefresh(coordinateSpaceName: "pullToRefresh") { }
            ForEach(["Lorem ipsum dolor sit amet, consectetuer adipiscing elit.",
               "Aliquam tincidunt mauris eu risus.",
               "Vestibulum auctor dapibus neque.",
               "Nunc dignissim risus id metus.",
               "Cras ornare tristique elit.",
               "Vivamus vestibulum ntulla nec ante.",
               "Praesent placerat risus quis eros."], id:\.self) { text in
                HStack(alignment: .center) {
                Text(text)
                    .padding()
                }
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)

            }
        }
    }
}
