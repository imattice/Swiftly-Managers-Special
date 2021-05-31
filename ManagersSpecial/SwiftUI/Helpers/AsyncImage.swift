//
//  AsyncImage.swift
//  ManagersSpecial
//
//  Created by Ike Mattice on 5/27/21.
//

import Foundation
import SwiftUI
import Combine


///A Image view that loads an image from an external URL
struct AsyncImage: View {
    ///A loader used to manage the download of the image file
    @ObservedObject
    private var imageLoader: ImageLoader
    ///An image to be shown before the downloaded image is loaded
    var placeholder: Image
    
    var body: some View {
        if let uiImage = self.imageLoader.downloadedImage {
            return Image(uiImage: uiImage)
                .resizable()
        } else {
            return placeholder
        }
    }
    
    init(url: String, placeholder: Image = Image(systemName: "photo")) {
        self.placeholder = placeholder
        self.imageLoader = ImageLoader(url: url)
    }
}



struct AsyncImage_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImage(url: "https://raw.githubusercontent.com/Swiftly-Systems/code-exercise-ios/master/images/L.png")
    }
}
