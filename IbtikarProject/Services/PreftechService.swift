//
//  PreftechService.swift
//  IbtikarProject
//
//  Created by Tariq Maged on 9/24/20.
//  Copyright © 2020 Tariq Maged. All rights reserved.
//

import Foundation
import UIKit


class PreftechService{
    
    //singlton
    static let instance = PreftechService()
    
    //vars
    var  homeServicesGroup:DispatchGroup?
    var complition:(()->Void)?
     var dispatchItems = 0 {
           didSet {
               if dispatchItems == 3 {
                if let complition = complition{
                        homeServicesGroup?.leave()
                        dispatchItems = 0
                        complition()
                }
               }
           }
    }

    
    func loadAndSaveData(vc:UIViewController, complition:@escaping (()->Void)){
        self.complition = complition
        homeServicesGroup = DispatchGroup()
        homeServicesGroup?.enter()
        DataServices.instance.getEpisodes { (success, episode) in
            if success{
                Storage.store(episode, to: .documents, as: FileSystemNames.episode.rawValue)
                self.dispatchItems += 1
            }else{
                vc.alertUser(message: "Connection Error")
            }
        }
        
        DataServices.instance.getCourses { (success, cources) in
            if success{
                Storage.store(cources, to: .documents, as: FileSystemNames.course.rawValue)
                self.dispatchItems += 1
            }else{
                vc.alertUser(message: "Connection Error")
            }
        }
        
        DataServices.instance.getCategories { (success, categories) in
            if success{
               Storage.store(categories, to: .documents, as: FileSystemNames.category.rawValue)
                self.dispatchItems += 1
            }else{
               vc.alertUser(message: "Connection Error")
            }
        }
    }
}
