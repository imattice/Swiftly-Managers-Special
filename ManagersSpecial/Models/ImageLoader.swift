//
//  ImageLoader.swift
//  ManagersSpecial
//
//  Created by Ike Mattice on 5/27/21.
//

import Foundation
import SwiftUI
import Combine

///A class that loads an image from a url
class ImageLoader: ObservableObject {
    ///The image downloaded from the URL
    @Published
    var downloadedImage: UIImage?
    
    func load(url: String, completion: (()->())? = nil) {
        guard let imageURL = URL(string: url)
        else { print("invalid url for async image download: \(url)"); return}
        
        URLSession.shared.dataTask(with: imageURL) { data, response, error in
            //Ensure data is returned and there are no errors.  Otherwise, continue showing the placeholder image
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    self.downloadedImage = nil
                }
                return
            }
            
            DispatchQueue.main.async {
                self.downloadedImage = UIImage(data: data)
                if let completion = completion {
                    completion()
                }
            }
            
        }.resume()
    }
}
