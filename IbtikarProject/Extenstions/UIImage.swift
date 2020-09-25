//
//  UIImage+Tinting.swift
//  zVendo
//
//  Created by Michael Maher on 3/19/19.
//  Copyright © 2019 Business Boomers. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    func fillImage(withColor color : UIColor!) -> UIImage {
        return UIImage(named: "")!
    }
    
    func toBase64() -> String? {
        guard let imageData = self.pngData() else { return nil }
        return imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
    }
    
    func maskWithColor(color: UIColor) -> UIImage {

        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        let context = UIGraphicsGetCurrentContext()!

        let rect = CGRect(origin: CGPoint.zero, size: size)

        color.setFill()
        self.draw(in: rect)

        context.setBlendMode(.sourceIn)
        context.fill(rect)

        let resultImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return resultImage
    }
    
    func overlayImage(color: UIColor) -> UIImage? {
           UIGraphicsBeginImageContextWithOptions(self.size, false, UIScreen.main.scale)
           let context = UIGraphicsGetCurrentContext()

           color.setFill()

           context!.translateBy(x: 0, y: self.size.height)
           context!.scaleBy(x: 1.0, y: -1.0)

           context!.setBlendMode(CGBlendMode.colorBurn)
           let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
           context!.draw(self.cgImage!, in: rect)

           context!.setBlendMode(CGBlendMode.sourceIn)
           context!.addRect(rect)
           context!.drawPath(using: CGPathDrawingMode.fill)

           let coloredImage = UIGraphicsGetImageFromCurrentImageContext()
           UIGraphicsEndImageContext()

           return coloredImage
       }
}

