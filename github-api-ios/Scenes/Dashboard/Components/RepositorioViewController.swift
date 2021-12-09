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
    @IBOutlet var nomeRepositorioLabel: UILabel!
    @IBOutlet var totalEstrelasLabel: UILabel!
    @IBOutlet var totalSeguidoresLabel: UILabel!
    @IBOutlet var totalForksLabel: UILabel!
    @IBOutlet var seguidoresTitleLabel: UILabel!
    @IBOutlet var forksTitleLabel: UILabel!
    @IBOutlet var dataTitleLabel: UILabel!

    let escuro: Bool = true
    override func viewDidLoad() {
        if !escuro {
            topView.backgroundColor = UIColor.white
            bottomView.backgroundColor = UIColor(red: 126, green: 126, blue: 126, alpha: 1)
            nomeRepositorioLabel.textColor = UIColor.black
            totalEstrelasLabel.textColor = UIColor.black
            totalSeguidoresLabel.textColor = UIColor.black
            seguidoresTitleLabel.textColor = UIColor.black
            forksTitleLabel.textColor = UIColor.black
            dataTitleLabel.textColor = UIColor.black
            totalForksLabel.textColor = UIColor.black
        }
    }
}
