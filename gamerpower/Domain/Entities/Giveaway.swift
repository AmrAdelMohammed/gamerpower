//
//  Giveaway.swift
//  gamerpower
//
//  Created by Amr Adel on 07/06/2024.
//

import Foundation

struct Giveaway: Codable, Identifiable, Equatable {
    var id: Int?
    var title, worth: String?
    var thumbnail, image: String?
    var description, instructions: String?
    var openGiveawayURL: String?
    var publishedDate: String?
    var type: TypeEnum?
    var platforms, endDate: String?
    var users: Int?
    var status: Status?
    var gamerpowerURL, openGiveaway: String?
    var isLoved: Bool = false {didSet{
        print(isLoved)
    }}
    var platformList: [String] {
        return (platforms?.split(separator: ",") ?? []).map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
    }
    
    enum CodingKeys: String, CodingKey {
        case id, title, worth, thumbnail, image, description, instructions
        case openGiveawayURL = "open_giveaway_url"
        case publishedDate = "published_date"
        case type, platforms
        case endDate = "end_date"
        case users, status
        case gamerpowerURL = "gamerpower_url"
        case openGiveaway = "open_giveaway"
    }
    
    static func ==(lhs: Giveaway, rhs: Giveaway) -> Bool {
        return lhs.id == rhs.id && lhs.isLoved == rhs.isLoved
    }
}

enum Status: String, Codable {
    case active = "Active"
}

enum TypeEnum: String, Codable {
    case dlc = "DLC"
    case earlyAccess = "Early Access"
    case game = "Game"
    case other = "Other"
}
