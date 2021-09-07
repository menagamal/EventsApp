//
//  CategoryModel.swift
//  EventsApp
//
//  Created by Mena Gamal on 05/09/2021.
//

import Foundation
struct CategoryModel : Codable {
    let name : String?
    let id : String?

    enum CodingKeys: String, CodingKey {

        case name = "name"
        case id = "id"
    }

    init() {
        name = ""
        id = ""
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        id = try values.decodeIfPresent(String.self, forKey: .id)
    }

}
