//
//  DataServices.swift
//  IbtikarProject
//
//  Created by Tariq Maged on 9/24/20.
//  Copyright © 2020 Tariq Maged. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class DataServices{
  
    static let instance = DataServices()
    
    
    func getEpisodes(complition: @escaping complitionEpisode){
          
          AF.request(URL_EPISODES, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
              
              let jsonDecoder = JSONDecoder()
              
              
              switch response.result {
              //case let .success(value):
              case  .success(_):
                  do{
                      let rsponseModel = try jsonDecoder.decode(EpisodeModel.self, from: response.data!)
                      complition(true,rsponseModel)
                  }catch{
                      debugPrint(error.localizedDescription)
                  }
              case let .failure(error):
                  print(error)
                  complition(false,nil)
              }
          }
      }
    
    func getCourses(complition: @escaping complitionCourse){
        
        AF.request(COURSE_URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            let jsonDecoder = JSONDecoder()
            
            
            switch response.result {
            //case let .success(value):
            case  .success(_):
                do{
                    let rsponseModel = try jsonDecoder.decode(CourseModel.self, from: response.data!)
                    complition(true,rsponseModel)
                }catch{
                    debugPrint(error.localizedDescription)
                }
            case let .failure(error):
                print(error)
                complition(false,nil)
            }
        }
    }
    
    func getCategories(complition:@escaping complitionCategories){
        AF.request(CATEGORY_URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
           guard let dataJson = response.data else {
            complition(false,nil)
                return}
            var categoryArr = [String]()
            switch response.result {
            case  .success(_):
                do{
                    guard let json = try JSON(data: dataJson).dictionary else {
                        complition(false,nil)
                        return}
                    let dataDict = json["data"]?.dictionaryValue
                    guard let categoryJsonArr = dataDict?["categories"]?.arrayValue else {return}
                    for category in categoryJsonArr{
                        let catName = category["name"].string ?? ""
                        categoryArr.append(catName)
                    }
                    complition(true,categoryArr)
                }catch{
                    debugPrint(error.localizedDescription)
                    complition(false,nil)
                }
                
            case let .failure(error):
                print(error)
                complition(false,nil)
            }
        }
    }
}
