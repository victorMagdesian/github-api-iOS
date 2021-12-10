//
//  DetailController.swift
//  github-api-ios
//
//  Created by ARYEL SANDER DOS SANTOS on 06/12/21.
//

import UIKit

class DetalheViewController: UIViewController {
    var coordinator: DashboardCoordinator?

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
        self.coordinator?.start()
    }

    @IBAction func compartilharButtonTapped(_ sender: Any) {
        let ownerName = "NOME-DO-USUARIO"
        let urlRepo = "https://github.com/\(ownerName)/\(repoName!)"

        let activityVC = UIActivityViewController(activityItems: [urlRepo], applicationActivities: [])
        activityVC.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(activityVC, animated: true)
    }
}
