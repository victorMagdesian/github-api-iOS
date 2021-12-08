//
//  FiltroViewController.swift
//  github-api-ios
//
//  Created by VICTOR FELIPPE MAGDESIAN on 06/12/21.
//

import UIKit

class FiltroViewController: UIViewController {

    var coordinator: DashboardCoordinator?

    @IBOutlet var starFilter: UIButton!
    @IBOutlet var followFilter: UIButton!
    @IBOutlet var dateFilter: UIButton!
    @IBOutlet var ascendingFilter: UIButton!
    @IBOutlet var descendingFilter: UIButton!

    var selectedButtons: [UIButton] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        let buttons: [UIButton] = [
            starFilter,
            followFilter,
            dateFilter,
            ascendingFilter,
            descendingFilter
        ]
//        starFilter.addTarget(
//            self,
//            action: #selector(tappedButton),
//            for: .touchUpInside
//        )

        for button in buttons {
            button.layer.borderColor = UIColor.black.cgColor
            button.layer.borderWidth = 1
            button.layer.cornerRadius = 4

            button.addTarget(
                self,
                action: #selector(tappedButton),
                for: .touchUpInside
            )
        }
    }

    @IBAction func goToMainController(_ sender: Any) {
        print("Indo pro main..")
        self.coordinator?.start()
    }

    @IBAction func limparFiltroButton(_ sender: UIButton) {
        if selectedButtons.isEmpty {
            return
        }

        selectedButtons.forEach {
            $0.backgroundColor = .none
            $0.titleLabel?.textColor = .black
            $0.setTitleColor(.black, for: .normal)
            $0.setImage(nil, for: .normal)
        }
    }

    @objc func tappedButton(_ sender: UIButton) {
        if sender.isHighlighted {
            sender.backgroundColor = .black
            sender.layer.cornerRadius = 4
            sender.setTitleColor(.white, for: .normal)

            sender.setImage(UIImage(named: "Checked"), for: .normal)
            selectedButtons.append(sender)
        } else {

            sender.backgroundColor = .none
            sender.setImage(nil, for: .normal)
//            sender.titleLabel?.textColor = .black

            sender.setTitleColor(.black, for: .normal)
        }
    }
}
