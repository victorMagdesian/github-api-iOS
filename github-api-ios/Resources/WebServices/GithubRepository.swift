//
//  GithubAPI.swift
//  github-api-ios
//
//  Created by ARYEL SANDER DOS SANTOS on 08/12/21.
//

import Foundation
import RxSwift

class GithubRepository {
    private let networkService = NetworkService()
    private let baseURLString = "https://api.github.com"

//    func getRepositories(_ order: Repositories.OrderBy = .descending, page: Int = 1) -> Observable<Repositories> {
//        let urlString = "\(baseURLString)/search/repositories?q=sort=stars&order=desc&per_page=100&page=\(page)"
//        return networkService.execute(url: URL(string: urlString)!)
//    }

    func getBranches(ownerName: String, repositoryName: String) -> Observable<[Branch]> {
        let urlString = baseURLString + "/repos/\(ownerName)/\(repositoryName)/branches"
        return networkService.execute(url: URL(string: urlString)!)
    }
    func getCommits(ownerName: String, repositoryName: String) -> Observable<[Commit]> {
        let urlString = baseURLString + "/repos/\(ownerName)/\(repositoryName)/commits"
        return networkService.execute(url: URL(string: urlString)!)
    }
    func getContributors(ownerName: String, repositoryName: String) -> Observable<[Contributor]> {
        let urlString = baseURLString + "/repos/\(ownerName)/\(repositoryName)/contributors"
        return networkService.execute(url: URL(string: urlString)!)
    }
    func getReleases(ownerName: String, repositoryName: String) -> Observable<[Release]> {
        let urlString = baseURLString + "/repos/\(ownerName)/\(repositoryName)/contributors"
        return networkService.execute(url: URL(string: urlString)!)
    }
    func getRepositoriesByName(
        repositoryName: String = "abc",
        _ sort: Repositories.FilterBy = .stars,
        _ order: Repositories.OrderBy = .desc,
        page: Int = 1) -> Observable<Repositories> {

        let url = "\(baseURLString)/search/" +
            "repositories?q=\(repositoryName)&" +
            "sort=\(sort)&" +
            "order=\(order)&" +
            "per_page=10&page=\(page)"

        return networkService.execute(url: URL(string: url)!)
    }
    func getReadme(ownerName: String, repositoryName: String) -> Observable<Data> {
        let urlString = "https://raw.githubusercontent.com/\(ownerName))/\(repositoryName))/master/README"
        return networkService.execute(url: URL(string: urlString)!)
      }
}

// abc - 435
// bitcoin-abc - 1052
