import Foundation
struct Repository: Decodable {
    let repositoryName: String
    let ownerName: String
    let stargazersCount: Int
    let watchersCount: Int
    let updatedAt: String
    let forksCount: Int
}

extension Repository {

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let owner = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .owner)
        repositoryName = try values.decode(String.self, forKey: .repositoryName)
        ownerName = try owner.decode(String.self, forKey: .ownerName)
        stargazersCount = try values.decode(Int.self, forKey: .stargazersCount)
        watchersCount = try values.decode(Int.self, forKey: .watchersCount)
        updatedAt = try values.decode(String.self, forKey: .updatedAt)
        forksCount = try values.decode(Int.self, forKey: .forksCount)
    }

     private enum CodingKeys: String, CodingKey {
        case repositoryName = "name"
        case owner
        case ownerName = "login"
        case stargazersCount = "stargazers_count"
        case watchersCount = "watchers_count"
        case updatedAt = "updated_at"
        case forksCount = "forks_count"
    }

}
