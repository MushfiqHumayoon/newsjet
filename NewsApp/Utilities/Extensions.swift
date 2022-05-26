//
//  Extensions.swift
//  NewsApp
//
//  Created by Mushfiq Humayoon on 26/05/22.
//

import UIKit
// MARK: - ViewIdentifier
extension UIView {
    public static func viewIdentifier() -> String {
        return String(describing: self)
    }
}
// MARK: - Load imageCache
let imageCache = NSCache<NSString, UIImage>()
extension UIImageView {
    func loadFrom(_ URLString: String, placeHolder: UIImage?) {
        self.image = nil
        if let cachedImage = imageCache.object(forKey: NSString(string: URLString)) {
            self.image = cachedImage
            return
        }
        if let url = URL(string: URLString) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if error != nil {
                    print("ERROR LOADING IMAGES FROM URL: \(String(describing: error))")
                    DispatchQueue.main.async {
                        self.image = placeHolder
                    }
                    return
                }
                DispatchQueue.main.async {
                    if let data = data {
                        if let downloadedImage = UIImage(data: data) {
                            imageCache.setObject(downloadedImage, forKey: NSString(string: URLString))
                            self.image = downloadedImage
                        }
                    }
                }
            }).resume()
        }
    }
}
