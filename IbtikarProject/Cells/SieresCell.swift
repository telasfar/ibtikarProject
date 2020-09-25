//
//  SieresCell.swift
//  IbtikarProject
//
//  Created by Tariq Maged on 9/22/20.
//  Copyright © 2020 Tariq Maged. All rights reserved.
//

import UIKit

class SieresCell: UITableViewCell {
    
    //var
    var latestMediaArr = [LatestMedia](){
        didSet{
            collectionViewEposide.reloadData()
        }
    }

    //outlets
    @IBOutlet weak var lblDetails: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgViewTitle: ShadowImage!
    @IBOutlet weak var collectionViewEposide: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }
    
    func setupCollectionView(){
           let eprisodeNib = UINib(nibName: EpisodeCell.identifier(), bundle: nil)
           collectionViewEposide.register(eprisodeNib, forCellWithReuseIdentifier: EpisodeCell.identifier())
          collectionViewEposide.delegate = self
          collectionViewEposide.dataSource = self
       }
    
    func configCell(channel:Channels?){
        if let channel = channel{
        latestMediaArr = channel.latestMedia ?? [LatestMedia]()
        lblTitle.text = channel.title ?? ""
        lblDetails.text = "\(channel.mediaCount ?? 0) Episodes"
        imgViewTitle.setupImage(withImageUrlPath: channel.iconAsset?.thumbnailUrl ?? "")
        imgViewTitle.layer.cornerRadius = imgViewTitle.frame.height/2
        }
    }

    open class func identifier() -> String {
        return String(describing:   SieresCell.self)
    }
    
}

extension SieresCell:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return latestMediaArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EpisodeCell.identifier(), for: indexPath) as? EpisodeCell else {return UICollectionViewCell()}
        
        cell.configCell(title:latestMediaArr[indexPath.item].title ?? "", url: latestMediaArr[indexPath.item].coverAsset?.url ?? "")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
    collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.width/2, height: collectionView.frame.height)
    }
}
