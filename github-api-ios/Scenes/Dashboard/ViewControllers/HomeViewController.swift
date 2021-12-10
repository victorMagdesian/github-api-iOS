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

    var paginationCount = 1

    override func viewDidLoad() {
        super.viewDidLoad()

        githubRepository.getRepositories()
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { (allRepos: Repositories) in
                    allRepos.repositories.forEach {

                        let repositoryHome = RepositoryHome(
                            repositoryName: $0.repositoryName,
                            ownerName: $0.ownerName,
                            stargazersCount: $0.stargazersCount,
                            watchersCount: $0.watchersCount,
                            updatedAt: $0.updatedAt,
                            forksCount: $0.forksCount
                        )

                        self.repositories.append(repositoryHome)

                    }
                }, onCompleted: {
                    for values in (0..<self.repositories.count) {

                        let repositoryView = RepositorioCustomView()

                        repositoryView.imageIcon.image = UIImage(named: "baixo_risco")
                        repositoryView.repositoryName.text = self.repositories[values].repositoryName
                        repositoryView.forksCount.text = String(self.repositories[values].forksCount)
                        repositoryView.stargazingCount.text = String(self.repositories[values].stargazersCount)
                        repositoryView.followersCount.text = String(self.repositories[values].watchersCount)
                        repositoryView.lastCommitDataInDays.text = self.repositories[values].getLastUpdatedDay() == 0 ? "Today" : String(self.repositories[values].getLastUpdatedDay())

                        if values.isMultiple(of: 2) {
                            self.invertBackgroundRepository(repositoryView)
                        }

                        repositoryView.translatesAutoresizingMaskIntoConstraints = false

                        self.repositoriesStackView.addArrangedSubview(repositoryView)

                        NSLayoutConstraint.activate([
                            repositoryView.heightAnchor.constraint(equalToConstant: 155),
                            repositoryView.widthAnchor.constraint(equalTo: self.repositoriesStackView.widthAnchor)
                        ])

                        repositoryView.addTarget(
                            self,
                            action: #selector(self.goToDetails),
                            for: .touchUpInside
                        )

                    }
                }).disposed(by: disposeViewBag)

        activityIndicatorView.isHidden = true

        if let buttonFilters = coordinator?.filters {
            filterCountLabel.text = String(buttonFilters.count)
            print("AAEIOU\(buttonFilters)")
            buttonFilters.forEach {
                $0.addTarget(self, action: #selector(removeFilter), for: .touchUpInside)

                filtrosHomeStackView.addArrangedSubview($0)
                filtrosHomeStackView.setCustomSpacing(8, after: $0)
            }
        }

        filterTextField.delegate = self
        scrollView.delegate = self

    }

    @IBAction func goToFilter(_ sender: Any) {
        coordinator?.filtro()
    }

    @IBAction func focusFilterTextField(_ sender: Any) {
        filterTextField.becomeFirstResponder()
    }

    @IBAction func clearFilters(_ sender: Any) {
        coordinator?.filters.removeAll()
        filtrosHomeStackView.subviews.forEach {$0.removeFromSuperview()}
        filterCountLabel.text = "0"
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

//        print("offsetY: \(offsetY) || contentHeight: \(contentHeight)")

        if offsetY > contentHeight - scrollView.frame.height {
            if !moreData {
                getMoreRepositories()
            }
        } else if offsetY < 0 {
            if !reloadData {
                refreshData()
            }
        }
    }

    func refreshData() {
        reloadData = true
        print("Reload dos dados")

        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
//            repositories = carregarDados()  Fazer uma nova requisição da API considerando os filtros da home
            print("atualizadoo\n")
            self.reloadData = false

        })
    }

    func getMoreRepositories() {
        moreData = true
        print("Pegando mais dado..")

        paginationCount += 1

//        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
//         let newRepositories = Requisição pro git pegando os próximos n repositórios
//            self.repositories.append(newRepositories)
//            print("++ dados\n")
//            self.moreData = false
//           self.repositoriesStackView.reloadInputViews() // ele usou um self.tableView.reloadData()
//        })

        githubRepository.getRepositories(page: paginationCount)
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { (allRepos: Repositories) in
                    allRepos.repositories.forEach {

                        let repositoryHome = RepositoryHome(
                            repositoryName: $0.repositoryName,
                            ownerName: $0.ownerName,
                            stargazersCount: $0.stargazersCount,
                            watchersCount: $0.watchersCount,
                            updatedAt: $0.updatedAt,
                            forksCount: $0.forksCount
                        )

                        self.repositories.append(repositoryHome)

                    }
                }, onCompleted: {
                    for values in (0..<self.repositories.count) {

                        let repositoryView = RepositorioCustomView()

                        repositoryView.imageIcon.image = UIImage(named: "baixo_risco")
                        repositoryView.repositoryName.text = self.repositories[values].repositoryName
                        repositoryView.forksCount.text = String(self.repositories[values].forksCount)
                        repositoryView.stargazingCount.text = String(self.repositories[values].stargazersCount)
                        repositoryView.followersCount.text = String(self.repositories[values].watchersCount)
                        repositoryView.lastCommitDataInDays.text = String(self.repositories[values].getLastUpdatedDay())

                        if values.isMultiple(of: 2) {
                            self.invertBackgroundRepository(repositoryView)
                        }

                        repositoryView.translatesAutoresizingMaskIntoConstraints = false

                        self.repositoriesStackView.addArrangedSubview(repositoryView)

                        NSLayoutConstraint.activate([
                            repositoryView.heightAnchor.constraint(equalToConstant: 155),
                            repositoryView.widthAnchor.constraint(equalTo: self.repositoriesStackView.widthAnchor)
                        ])

                        repositoryView.addTarget(
                            self,
                            action: #selector(self.goToDetails),
                            for: .touchUpInside
                        )
                        self.moreData = false
                    }
                }).disposed(by: disposeViewBag)
    }
}

extension HomeViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activityIndicatorView.isHidden = false
    }

    func textFieldDidChangeSelection(_ textField: UITextField) {
        activityIndicatorView.isHidden = false

    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        filterTextField.endEditing(true)
        super.touchesBegan(touches, with: event)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        activityIndicatorView.isHidden = true
    }

}

extension HomeViewController {
    @objc private func removeFilter(_ sender: UIButton) {
        sender.isSelected = false

        guard let indexButton = coordinator?.filters.firstIndex(of: sender) else {
            return
        }

        coordinator?.filters.remove(at: indexButton)

        guard let countFilters = coordinator?.filters.count else { return }

        filterCountLabel.text = String(countFilters)

        UIView.animate(withDuration: 0.4, delay: 0, options: []) {
            sender.transform = CGAffineTransform(translationX: 0, y: 20)
            sender.alpha = 0
        } completion: { _ in
            sender.removeFromSuperview()
        }
    }

    private func invertBackgroundRepository(_ repositoryView: RepositorioCustomView) {
        repositoryView.topView.backgroundColor = .white

        repositoryView.bottomView.backgroundColor = UIColor(
            red: CGFloat(126)/CGFloat(255),
            green: CGFloat(126)/CGFloat(255),
            blue: CGFloat(126)/CGFloat(255),
            alpha: 1
        )

        repositoryView.totalStarsLabel.textColor = .black
        repositoryView.repositoryName.textColor = .black
        repositoryView.stargazingCount.textColor = .black
    }

    @objc func goToDetails(_ sender: Any) {
        coordinator?.details()
    }
}
