//
//  Series.swift
//  IbtikarProject
//
//  Created by Tariq Maged on 9/24/20.
//  Copyright © 2020 Tariq Maged. All rights reserved.
//

import Foundation
struct Series : Codable {
    let title : String?
    let coverAsset : CoverAsset?


    enum CodingKeys: String, CodingKey {
        case coverAsset = "coverAsset"
        case title = "title"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        coverAsset = try values.decodeIfPresent(CoverAsset.self, forKey: .coverAsset)
    }

}
