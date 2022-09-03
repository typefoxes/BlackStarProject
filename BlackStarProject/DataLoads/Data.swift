//
//  Data.swift
//  BlackStarProject
//
//  Created by Fox on 01.09.2022.
//

import Foundation
import RealmSwift

struct DataAll: Codable {
    let id: Int
    let title: String
    let price: String
    let descriptions: String
    let category: String
    let image: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case price = "price"
        case descriptions = "description"
        case category = "category"
        case image = "image"
}
}
class saveIt: Object {
 //   @objc dynamic var id: String? = "\(Int.self)"
    @objc dynamic var title: String? = ""
    @objc dynamic var price: String? = ""
    @objc dynamic var descriptions: String? = ""
    @objc dynamic var category: String? = ""
    @objc dynamic var image: String? = ""
}
