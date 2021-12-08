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

    @IBOutlet var applyFilter: UIButton!

    var selectedButtons: [UIButton] = []

    override func viewDidLoad() {
        print("Entrou aqui dnv no filtro")
        super.viewDidLoad()

        let buttons: [UIButton] = [
            starFilter,
            followFilter,
            dateFilter,
            ascendingFilter,
            descendingFilter
        ]

        applyFilter.layer.cornerRadius = 4

        for button in buttons {
            button.layer.borderColor = UIColor.black.cgColor
            button.layer.borderWidth = 1
            button.layer.cornerRadius = 4
            button.setImage(nil, for: .normal)

            button.addTarget(
                self,
                action: #selector(tappedButton),
                for: .touchUpInside
            )
        }
    }

    @IBAction func goToHome(_ sender: Any) {
        print("Indo pro main..")
        self.coordinator?.start()
    }

    @IBAction func limparFiltroButton(_ sender: UIButton) {
        if selectedButtons.isEmpty {
            return
        }

        selectedButtons.forEach {
            $0.backgroundColor = .none
            $0.setImage(nil, for: .normal)
            $0.setTitleColor(.black, for: .selected)
            $0.isSelected = false
        }

        selectedButtons.removeAll()
    }

    @objc func tappedButton(_ sender: UIButton) {
        let titleLabel = sender.titleLabel?.text

        let existingAscendingButton = selectedButtons.first(
            where: { button in button.titleLabel?.text == "CRESCENTE" }
        )

        let existingDescendingButton = selectedButtons.first(
            where: { button in button.titleLabel?.text == "DECRESCENTE" }
        )

        if titleLabel == "DECRESCENTE" && existingAscendingButton != nil {
            existingAscendingButton?.isSelected = false
            setStyleButtonUnSelected(existingAscendingButton!)

        } else if titleLabel == "CRESCENTE" && existingDescendingButton != nil {
            existingDescendingButton?.isSelected = false
            setStyleButtonUnSelected(existingDescendingButton!)
        }

        if sender.isSelected {
            sender.isSelected = false

            setStyleButtonUnSelected(sender)
            selectedButtons.remove(at: selectedButtons.firstIndex(of: sender)!)
        } else {
            sender.isSelected = true

            setStyleButtonSelected(sender)
            selectedButtons.append(sender)
        }
    }

    @IBAction func applyButton(_ sender: UIButton) {
        print("aplicando filtro...")

        var filtersName = [String]()

        selectedButtons.forEach {
            filtersName.append(($0.titleLabel?.text)!)
        }

        print(filtersName)

        coordinator?.applyFilters(filters: filtersName)
        coordinator?.sendBackToHome()
    }
}

extension FiltroViewController {
    private func setStyleButtonSelected(_ button: UIButton) {
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .selected)
        button.setImage(UIImage(named: "Checked"), for: .normal)
    }

    private func setStyleButtonUnSelected(_ button: UIButton) {
        button.backgroundColor = .none
        button.setImage(nil, for: .normal)
        button.setTitleColor(.black, for: .normal)
    }
}
