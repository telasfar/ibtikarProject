/* 
Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Channels : Codable {
	let title : String?
	let series : [Series]?
	let mediaCount : Int?
	let latestMedia : [LatestMedia]?
	let id : String?
	let iconAsset : IconAsset?
	let coverAsset : CoverAsset?

	enum CodingKeys: String, CodingKey {

		case title = "title"
		case series = "series"
		case mediaCount = "mediaCount"
		case latestMedia = "latestMedia"
		case id = "id"
		case iconAsset = "iconAsset"
		case coverAsset = "coverAsset"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		series = try values.decodeIfPresent([Series].self, forKey: .series)
		mediaCount = try values.decodeIfPresent(Int.self, forKey: .mediaCount)
		latestMedia = try values.decodeIfPresent([LatestMedia].self, forKey: .latestMedia)
		id = try values.decodeIfPresent(String.self, forKey: .id)
		iconAsset = try values.decodeIfPresent(IconAsset.self, forKey: .iconAsset)
		coverAsset = try values.decodeIfPresent(CoverAsset.self, forKey: .coverAsset)
	}

}
