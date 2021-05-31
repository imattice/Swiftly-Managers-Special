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
    ///The url where the image is located
    let url: String
    ///A cache to store downloaded images
    var imageCache = ImageCache.getImageCache()

    
    init(url: String) {
        self.url = url
        loadImage()
    }
    
    ///Load the image from the URL
    func loadImage(completion: (()->())? = nil) {
        guard !canLoadCachedImage() else { return }
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
                guard let image = UIImage(data: data) else { return }
                self.downloadedImage = image
                self.imageCache.set(forKey: self.url, image: image)
                
                if let completion = completion {
                    completion()
                }
            }
            
        }.resume()
    }
    
    func canLoadCachedImage() -> Bool {
        guard let cacheImage = imageCache.get(forKey: url) else {
            return false
        }
        
        downloadedImage = cacheImage
        return true
    }
}

///Used to cache the downloaded image file
class ImageCache {
    var cache = NSCache<NSString, UIImage>()
    
    func get(forKey: String) -> UIImage? {
        return cache.object(forKey: NSString(string: forKey))
    }
    
    func set(forKey: String, image: UIImage) {
        cache.setObject(image, forKey: NSString(string: forKey))
    }
}

extension ImageCache {
    private static var imageCache = ImageCache()
    static func getImageCache() -> ImageCache {
        return imageCache
    }
}
