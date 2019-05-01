//
//  Extensions.swift
//  YouTube
//
//  Created by Vladimir on 4/22/19.
//  Copyright © 2019 epam. All rights reserved.
//

import UIKit

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(displayP3Red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

extension UIView {
    func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

let imageChache = NSCache<NSString, UIImage>()

class CustomImageView: UIImageView {
    
    var imageUrlString: String?
    
    
    func loadImage(usingUrlString urlString: String) {
        
        imageUrlString = urlString
        
        let url = URL(string: urlString)
        
        image = nil
        
        if let imageFromChache = imageChache.object(forKey: urlString as NSString) {
            self.image = imageFromChache
            return
        }
        
        URLSession.shared.dataTask(with: url!) { (data, response, err) in
            if err != nil {
                print(err!)
                return
            }
            
            DispatchQueue.main.async {
                
                let imageToCache = UIImage(data: data!)
                
                
                
                if self.imageUrlString == urlString {
                    self.image = imageToCache
                }
                imageChache.setObject(imageToCache!, forKey: urlString as NSString)

            }
            }.resume()
    }
    
}
