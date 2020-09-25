//
//  Constants.swift
//  IbtikarProject
//
//  Created by Tariq Maged on 9/24/20.
//  Copyright © 2020 Tariq Maged. All rights reserved.
//

import Foundation

//URL
let CATEGORY_URL = "https://pastebin.com/raw/A0CgArX3"
let URL_EPISODES = "https://pastebin.com/raw/Xt12uVhM"
let COURSE_URL = "https://pastebin.com/raw/z5AExTtw"

//typealias
typealias complitionCategories = (_ status:Bool,_ catArr:[String]?)->()
typealias complitionEpisode = (_ status:Bool,_ episode:EpisodeModel?)->()
typealias complitionCourse = (_ status:Bool,_ episode:CourseModel?)->()


//Enums
enum FileSystemNames:String{
    case course = "courseName"
    case episode = "eposideName"
    case category = "categoryName"
}
