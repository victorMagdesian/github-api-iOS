//
//  Repositories.swift
//  github-api-ios
//
//  Created by ARYEL SANDER DOS SANTOS on 08/12/21.
//

import RxSwift
struct Repositories: Decodable {

    let repositories: [Repository]

    enum FilterBy: String {
        case stars
        case watchers
        case data
    }

    enum OrderBy: String {
        case asc
        case desc

    }
}

extension Repositories {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        repositories = try values.decode([Repository].self, forKey: .repositories)
    }
    private enum CodingKeys: String, CodingKey {
        case repositories = "items"
    }
}
