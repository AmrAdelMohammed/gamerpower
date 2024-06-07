//
//  Endpoint.swift
//  gamerpower
//
//  Created by Amr Adel on 07/06/2024.
//


import Foundation
import Moya

enum API {
    case getGiveaways(platform: String?)
}

extension API: TargetType {
    var baseURL: URL {
        return URL(string: "https://www.gamerpower.com")!
    }

    var path: String {
        return "/api/giveaways"
    }

    var method: Moya.Method {
        return .get
    }

    var task: Task {
        switch self {
        case let .getGiveaways(platform):
            if let platform = platform {
                return .requestParameters(parameters: ["platform": platform], encoding: URLEncoding.queryString)
            } else {
                return .requestPlain
            }
        }
    }

    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }

    var sampleData: Data {
        return Data()
    }
}


