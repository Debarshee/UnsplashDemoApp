//
//  UIImageView+Ext.swift
//  MoviesInfoAppDemo
//
//  Created by Debarshee on 4/11/21.
//

import UIKit

extension UIImageView {
    
    static var imageCache = ImageCache()
    
    func downloadImage(with url: String?) {
        guard let unwrappedUrl = url, let mainUrl = URL(string: unwrappedUrl) else {
            self.image = UIImage(named: "defaultPlaceholder")
            return
        }
        
        if let image = UIImageView.imageCache.getImage(for: NSString(string: unwrappedUrl)) {
            self.image = image
            return
        }
        
        URLSession.shared.dataTask(with: mainUrl) { data, _, _ in
            guard let data = data else {
                self.image = UIImage(named: "defaultPlaceholder")
                return
            }
            DispatchQueue.main.async {
                guard let image = UIImage(data: data) else { return }
                UIImageView.imageCache.saveImage(image, for: NSString(string: unwrappedUrl))
                self.image = UIImage(data: data)
            }
        }
        .resume()
    }
}

extension UIView {
    enum ViewSide {
        case left, right, top, bottom
    }
    
    func addBorder(toSide side: ViewSide, withColor color: CGColor, andThickness thickness: CGFloat) {
        
        let border = CALayer()
        border.backgroundColor = color
        
        switch side {
        case .left:
            border.frame = CGRect(x: frame.minX, y: frame.minY, width: thickness, height: frame.height)
            
        case .right:
            border.frame = CGRect(x: frame.maxX, y: frame.minY, width: thickness, height: frame.height)
            
        case .top:
            border.frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: thickness)
            
        case .bottom:
            border.frame = CGRect(x: frame.minX, y: frame.maxY, width: frame.width, height: thickness)
        }
        
        layer.addSublayer(border)
    }
}
