//
//  EventModel.swift
//  EventsApp
//
//  Created by Mena Gamal on 05/09/2021.
//

import Foundation
struct EventModel : Codable {
    let longitude : String?
    let latitude : String?
    let end_date : String?
    let start_date : String?
    let description : String?
    let cover : String?
    let name : String?
    let id : String?

    enum CodingKeys: String, CodingKey {

        case longitude = "longitude"
        case latitude = "latitude"
        case end_date = "end_date"
        case start_date = "start_date"
        case description = "description"
        case cover = "cover"
        case name = "name"
        case id = "id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        longitude = try values.decodeIfPresent(String.self, forKey: .longitude)
        latitude = try values.decodeIfPresent(String.self, forKey: .latitude)
        end_date = try values.decodeIfPresent(String.self, forKey: .end_date)
        start_date = try values.decodeIfPresent(String.self, forKey: .start_date)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        cover = try values.decodeIfPresent(String.self, forKey: .cover)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        id = try values.decodeIfPresent(String.self, forKey: .id)
    }

}
