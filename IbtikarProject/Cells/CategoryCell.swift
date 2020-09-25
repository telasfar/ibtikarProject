//
//  CategoryCell.swift
//  IbtikarProject
//
//  Created by Tariq Maged on 9/24/20.
//  Copyright © 2020 Tariq Maged. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lblCategory: UILabel!
    
    open class func identifier() -> String {
        return String(describing: CategoryCell.self)
    }
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        lblCategory.clipsToBounds = true
//        lblCategory.layer.cornerRadius = lblCategory.frame.height/10
//    }
    
}
