//
//  ShadowImage.swift
//  Arkan
//
//  Created by BinaryCase on 1/3/19.
//  Copyright © 2019 Tariq. All rights reserved.
//

import UIKit

class ShadowImage: UIImageView {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius =  12//self.frame.height / 10
        layer.shadowOpacity = 0.3
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 0, height: 5)
    }
}
