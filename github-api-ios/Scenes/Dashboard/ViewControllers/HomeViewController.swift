//
//  MainViewController.swift
//  github-api-ios
//
//  Created by VICTOR PEREIRA MOURA on 06/12/21.
//

import UIKit
import RxSwift

class HomeViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet var searchButton: UIButton!
    @IBOutlet var filterTextField: UITextField!
    @IBOutlet var activityIndicatorView: UIView!
    @IBOutlet var filterCountLabel: UILabel!
    @IBOutlet var filtrosHomeStackView: UIStackView!

    @IBOutlet var repositoriesStackView: UIStackView!
    @IBOutlet var scrollView: UIScrollView!

    var coordinator: DashboardCoordinator?
    var selectedFilters = [UIView]()
    var moreData = false
    var reloadData = false

    let githubRepository = GithubRepository()
    let disposeViewBag = DisposeBag()

    var repositories = [RepositoryHome]()
    var repoName: String = "abc"
    var repositoriesCount = 0

    var paginationCount = 1
    var filtersSelected = [String]()
    var orderFilter: Repositories.OrderBy?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let buttonFilters = coordinator?.filters {
            filterCountLabel.text = String(buttonFilters.count)

            buttonFilters.forEach {
                $0.addTarget(self, action: #selector(removeFilter), for: .touchUpInside)

                filtrosHomeStackView.addArrangedSubview($0)
                filtrosHomeStackView.setCustomSpacing(8, after: $0)

                if let textButton = $0.titleLabel?.text {
                    filtersSelected.append(textButton)
                }
            }

            if filtersSelected.contains("CRESCENTE") {
                orderFilter = .asc
            } else if filtersSelected.contains("DECRESCENTE") {
                orderFilter = .desc
            } else {
                orderFilter = .defaultFilter
            }

            initializeReposInHome(
                repoName: repoName,
                filtersSelected.contains("ESTRELAS") ? .stars : .defaultFilter,
                orderFilter ?? .defaultFilter
            )
        }

        filterTextField.delegate = self
        scrollView.delegate = self

    }

    @IBAction func goToFilter(_ sender: Any) {
        coordinator?.filtro()
    }

    @objc func goToDetails(_ sender: RepositorioCustomView) {
        coordinator?.details(sender)
    }

    @IBAction func focusFilterTextField(_ sender: Any) {
        filterTextField.becomeFirstResponder()
    }

    @IBAction func clearFilters(_ sender: Any) {
        coordinator?.filters.removeAll()
        filtersSelected.removeAll()

        filtrosHomeStackView.subviews.forEach {$0.removeFromSuperview()}
        filterCountLabel.text = "0"
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if offsetY > contentHeight - scrollView.frame.height {
            if !moreData {
                getMoreRepositories(
                    repoName: repoName,
                    filtersSelected.contains("ESTRELAS") ? .stars : .defaultFilter,
                    orderFilter ?? .defaultFilter
                )
            }
        } else if offsetY < 0 {
            if !reloadData {
                refreshData()
            }
        }
    }

    func refreshData() {
        reloadData = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.reloadData = false

        })
    }

    @IBAction func searchByName(_ sender: UITextField) {
        self.repositories.removeAll()

        for view in repositoriesStackView.arrangedSubviews {
            view.removeFromSuperview()
        }
        repoName = sender.text!
        initializeReposInHome(
            repoName: repoName,
            filtersSelected.contains("ESTRELAS") ? .stars : .defaultFilter,
            orderFilter ?? .defaultFilter
        )

    }

    func getMoreRepositories(
        repoName: String,
        _ sort: Repositories.FilterBy = .stars,
        _ order: Repositories.OrderBy = .desc,
        page: Int = 1) {

        moreData = true
        paginationCount += 1

        githubRepository.getRepositoriesByName(
            repositoryName: repoName, sort: sort, order: order, page: paginationCount)
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { (allRepos: Repositories) in
                    self.onNextMoreRepos(allRepos, repositoriesCount: self.repositoriesCount)
                }, onCompleted: {
                    self.onCompletedMoreRepos(self.repositories)
                }).disposed(by: disposeViewBag)
    }

    func initializeReposInHome (
        repoName: String,
        _ sort: Repositories.FilterBy = .stars,
        _ order: Repositories.OrderBy = .desc,
        page: Int = 1) {

        githubRepository.getRepositoriesByName(
            repositoryName: repoName, sort: sort, order: order, page: page)
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { (allRepos: Repositories) in
                    self.onNextFirstTime(allRepos)

                }, onCompleted: {
                    self.onCompletedFirstTime(self.repositories)
                }).disposed(by: disposeViewBag)

        activityIndicatorView.isHidden = true
    }
}
