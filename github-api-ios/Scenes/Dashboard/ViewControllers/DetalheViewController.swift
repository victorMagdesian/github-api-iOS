//
//  DetailController.swift
//  github-api-ios
//
//  Created by ARYEL SANDER DOS SANTOS on 06/12/21.
//

import UIKit
import RxSwift

class DetalheViewController: UIViewController {
    var coordinator: DashboardCoordinator?
    var repository: RepositorioCustomView?

    let disposeViewBag = DisposeBag()
    let githubRepository = GithubRepository()

    @IBOutlet var repoIcon: UIImageView!
    @IBOutlet var repoName: UILabel!
    @IBOutlet var totalEstrelas: UILabel!
    @IBOutlet var totalCommits: UILabel!
    @IBOutlet var totalBranchs: UILabel!
    @IBOutlet var totalReleases: UILabel!
    @IBOutlet var totalColaborators: UILabel!
    @IBOutlet var readmeText: UITextView!

    override var nibName: String? {
        "DetalheViewController"
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let repositoryView = repository else { return }

        repoIcon.image = repositoryView.imageIcon.image
        repoName.text = repositoryView.repositoryName.text
        totalEstrelas.text = repositoryView.stargazingCount.text

        guard let ownerName = repositoryView.ownerName,
              let repositoryName = repoName.text else { return }

        getRepositoryCommitsCount(ownerName: ownerName, repositoryName: repositoryName)
        getRepositoryBranchsCount(ownerName: ownerName, repositoryName: repositoryName)
        getRepositoryReleasesCount(ownerName: ownerName, repositoryName: repositoryName)
        getRepositoryColaboratorsCount(ownerName: ownerName, repositoryName: repositoryName)
        readmeText.text = githubRepository.getReadme(ownerName: ownerName, repositoryName: repositoryName)
        readmeText.textColor = .black
    }

    @IBAction func voltarButtonTapped(_ sender: Any) {
        self.coordinator?.start()
    }

    @IBAction func compartilharButtonTapped(_ sender: Any) {
        let urlRepo = "https://github.com/\(repository!.ownerName!)/\(repoName.text!)"

        let activityVC = UIActivityViewController(activityItems: [urlRepo], applicationActivities: [])
        activityVC.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(activityVC, animated: true)
    }
}

extension DetalheViewController {

    private func getRepositoryCommitsCount(ownerName: String, repositoryName: String) {
        githubRepository.getCommits(ownerName: ownerName, repositoryName: repositoryName)
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { (commits) in
                    self.totalCommits.text = commits.count == 0 ? "0" : String(commits.count)
                }).disposed(by: disposeViewBag)
    }

    private func getRepositoryReleasesCount(ownerName: String, repositoryName: String) {
        githubRepository.getReleases(ownerName: ownerName, repositoryName: repositoryName)
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { (releases) in
                    self.totalReleases.text = releases.count == 0 ? "0" : String(releases.count)
                }).disposed(by: disposeViewBag)
    }

    private func getRepositoryBranchsCount(ownerName: String, repositoryName: String) {
        githubRepository.getBranches(ownerName: ownerName, repositoryName: repositoryName)
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { (branchs) in
                    self.totalBranchs.text = branchs.count == 0 ? "0" : String(branchs.count)
                }).disposed(by: disposeViewBag)
    }

    private func getRepositoryColaboratorsCount(ownerName: String, repositoryName: String) {
        githubRepository.getContributors(ownerName: ownerName, repositoryName: repositoryName)
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { (contributors) in
                    self.totalColaborators.text = contributors.count == 0 ? "0" : String(contributors.count)
                }).disposed(by: disposeViewBag)
    }

}
