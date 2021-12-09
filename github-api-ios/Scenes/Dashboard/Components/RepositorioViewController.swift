//
//  RepositorioView.swift
//  github-api-ios
//
//  Created by VICTOR PEREIRA MOURA on 09/12/21.
//

import UIKit
class RepositorioViewController: UIViewController {

    @IBOutlet var topView: UIView!
    @IBOutlet var bottomView: UIView!
    @IBOutlet var repositoryName: UILabel!
    @IBOutlet var stargazerCountLabel: UILabel!
    @IBOutlet var watcherCountLabel: UILabel!
    @IBOutlet var forkCountLabel: UILabel!
    @IBOutlet var watchersTitleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var forksTitleLabel: UILabel!
    @IBOutlet var dateTitleLabel: UILabel!

    let isDark: Bool = true

    override func viewDidLoad() {
        if !isDark {
            topView.backgroundColor = UIColor.white
            bottomView.backgroundColor = UIColor(red: 126, green: 126, blue: 126, alpha: 1)
            repositoryName.textColor = UIColor.black
            stargazerCountLabel.textColor = UIColor.black
            watcherCountLabel.textColor = UIColor.black
            forkCountLabel.textColor = UIColor.black
            watchersTitleLabel.textColor = UIColor.black
            forksTitleLabel.textColor = UIColor.black
            dateTitleLabel.textColor = UIColor.black
        }
    }
}
