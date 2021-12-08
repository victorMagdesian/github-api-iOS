//
//  DetailController.swift
//  github-api-ios
//
//  Created by ARYEL SANDER DOS SANTOS on 06/12/21.
//

import UIKit

class DetalheViewController: UIViewController {

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
        }

    @IBAction func voltarButtonTapped(_ sender: Any) {
    }

    @IBAction func compartilharButtonTapped(_ sender: Any) {
    }
}
