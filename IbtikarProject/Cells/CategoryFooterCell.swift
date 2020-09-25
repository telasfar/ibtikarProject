//
//  CategoryFooterCell.swift
//  IbtikarProject
//
//  Created by Tariq Maged on 9/22/20.
//  Copyright © 2020 Tariq Maged. All rights reserved.
//

import UIKit

class CategoryFooterCell: UITableViewHeaderFooterView {
    
    //vars
    let categoryArr = Storage.retrieve(FileSystemNames.category.rawValue, from: .documents, as: [String].self)
    
    //outlet
    @IBOutlet weak var collectionViewCategory: UICollectionView!
    
    open class func identifier() -> String {
           return String(describing:   CategoryFooterCell.self)
       }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }

  func setupCollectionView(){
      let eprisodeNib = UINib(nibName: CategoryCell.identifier(), bundle: nil)
      collectionViewCategory.register(eprisodeNib, forCellWithReuseIdentifier: CategoryCell.identifier())
     collectionViewCategory.delegate = self
     collectionViewCategory.dataSource = self
  }
    
}

extension CategoryFooterCell:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier(), for: indexPath) as? CategoryCell else {return UICollectionViewCell()}
        cell.lblCategory.text = categoryArr[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
    collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numColumn: CGFloat = 2
        let spaceBetweenCells : CGFloat = 4
        let padding: CGFloat = 8
        let cellDimention = (collectionView.bounds.width - padding - spaceBetweenCells) / numColumn
        return CGSize(width: cellDimention, height: collectionView.frame.height/4 )
    }
}
