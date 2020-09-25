//
//  ShadowLabel.swift
//  Arkan
//
//  Created by BinaryCase on 1/2/19.
//  Copyright © 2019 Tariq. All rights reserved.
//

import UIKit

class ShadowLabel: UILabel {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = frame.height/12
        self.layer.shadowOpacity = 0.3
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowRadius = 2.0
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
    }

}
