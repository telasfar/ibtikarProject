//
//  EpisodeCell.swift
//  IbtikarProject
//
//  Created by Tariq Maged on 9/22/20.
//  Copyright © 2020 Tariq Maged. All rights reserved.
//

import UIKit

class EpisodeCell: UICollectionViewCell {

    //Outlets
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgView: ShadowImage!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    open class func identifier() -> String {
           return String(describing:   EpisodeCell.self)
       }
    
    func configCell(title:String,url:String){
        lblTitle.text = title
        imgView.setupImage(withImageUrlPath: url)
       
    }
}
