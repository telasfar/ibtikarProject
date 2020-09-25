//
//  ChannelHeaderCell.swift
//  IbtikarProject
//
//  Created by Tariq Maged on 9/22/20.
//  Copyright © 2020 Tariq Maged. All rights reserved.
//

import UIKit

class ChannelHeaderCell: UITableViewHeaderFooterView {
    
    var episodeModel = Storage.retrieve(FileSystemNames.episode.rawValue, from: .documents, as: EpisodeModel.self)

    

    @IBOutlet weak var collectionViewEpisd: UICollectionView!
    
    
    open class func identifier() -> String {
              return String(describing:   ChannelHeaderCell.self)
          }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
        collectionViewEpisd.reloadData()
    }

    func setupCollectionView(){
        let eprisodeNib = UINib(nibName: EpisodeCell.identifier(), bundle: nil)
        collectionViewEpisd.register(eprisodeNib, forCellWithReuseIdentifier: EpisodeCell.identifier())
       collectionViewEpisd.delegate = self
       collectionViewEpisd.dataSource = self
    }
}

extension ChannelHeaderCell:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return episodeModel.data?.channels?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EpisodeCell.identifier(), for: indexPath) as? EpisodeCell else {return UICollectionViewCell()}
        if let channelArr = episodeModel.data?.channels{
            cell.configCell(title:channelArr[indexPath.item].title ?? "" , url: channelArr[indexPath.item].latestMedia?.first?.coverAsset?.url ?? "")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
    collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.width/2, height: collectionView.frame.height)
    }
}
