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
        case estrelas = "stars"
        case seguidores = "watchers"
        case data = "data"
    }

    enum OrderBy: String {
        case ascending = "?q=order=asc"
        case descending = "?q=order=desc"

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
