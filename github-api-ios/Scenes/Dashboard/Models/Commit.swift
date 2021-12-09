//
//  Commit.swift
//  github-api-ios
//
//  Created by ARYEL SANDER DOS SANTOS on 08/12/21.
//

import Foundation
struct Commit: Decodable {

     let date: String

}

extension Commit {

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let commit = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .commit)
        let author = try commit.nestedContainer(keyedBy: CodingKeys.self, forKey: .author)
        date = try author.decode(String.self, forKey: .date)
    }

    private enum CodingKeys: String, CodingKey {
        case commit
        case date
        case author
    }
    func getDaysFromThisCommit() -> Int {
        let dateFormatter = DateFormatter()
        let calendar = Calendar.current
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date1 = calendar.startOfDay(for: Date())
        let date2 = dateFormatter.date(from: date)!
        let components = Calendar.current.dateComponents([.day], from: date2, to: date1).day
        return components!
    }

}
