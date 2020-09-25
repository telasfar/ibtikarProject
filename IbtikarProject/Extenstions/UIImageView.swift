//
//  UIImageView.swift
//  zVendo
//
//  Created by Ahmad Ismail on 12/31/18.
//  Copyright © 2018 Business Boomers. All rights reserved.
//

import SDWebImage
import UIKit
//import Kingfisher

extension UIImageView {
    
    //================================
    //MARK: Create Image with URL path
    //================================
    func setupImage(withImageUrlPath urlPath: String) {
        let encodedPath = urlPath.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        let urlString = urlPath
        
        //"\(StoreGlobalData.imagesUrl)"  + "\(encodedPath ?? urlPath)"
        
        self.sd_imageTransition = .flipFromBottom
        self.sd_setIndicatorStyle(.gray)
        self.sd_addActivityIndicator()
        guard let url = URL(string: urlString) else {return}
        self.sd_setImage(with: url, placeholderImage: nil, options: [.retryFailed,.continueInBackground], progress: { (completed, total, url) in
            if completed == total {
                
            }
        }) { (image, error, _, _) in
            DispatchQueue.main.async {

            if error == nil {
               
                self.image = image
            } else {
                let anyImage = UIImage(named: "ibtikar")
                self.image = anyImage
                self.contentMode = .scaleAspectFit
            }
           // self.backgroundColor = image?.getColors(quality: .low)?.background
            }
        }
    } // setup image with URL path
        
    //=================
    //MARK: Drop Shadow
    //=================
    func addShadow() {
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
    } // dropShadow
    
    func setImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
}
