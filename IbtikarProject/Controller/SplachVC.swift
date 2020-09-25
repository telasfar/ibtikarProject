//
//  SplachVC.swift
//  IbtikarProject
//
//  Created by Tariq Maged on 9/24/20.
//  Copyright © 2020 Tariq Maged. All rights reserved.
//

import UIKit

class SplachVC: UIViewController {
    
    //vars
    let isStoredBefore = Storage.fileExists(FileSystemNames.category.rawValue, in: .documents) && Storage.fileExists(FileSystemNames.episode.rawValue, in: .documents) && Storage.fileExists(FileSystemNames.course.rawValue, in: .documents)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(self.handleApiAndStorage), userInfo: nil, repeats: false)        
    }
    
    @objc func handleApiAndStorage(){
        if isStoredBefore{
           segueToHomeVC()
        }else{
            PreftechService.instance.loadAndSaveData(vc: self) {
                DispatchQueue.main.async {
                    self.segueToHomeVC()
                }
            }
        }
    }
   
    func segueToHomeVC(){
        if  let homeVc = storyboard?.instantiateViewController(identifier: "HomeVC") as? HomeVC{
            presentDetail(homeVc)
        }
    }
}
