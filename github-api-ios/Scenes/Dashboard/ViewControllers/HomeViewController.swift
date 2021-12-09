//
//  MainViewController.swift
//  github-api-ios
//
//  Created by VICTOR PEREIRA MOURA on 06/12/21.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet var searchButton: UIButton!
    @IBOutlet var filterTextField: UITextField!
    @IBOutlet var activityIndicatorView: UIView!
    @IBOutlet var filterCountLabel: UILabel!
    @IBOutlet var filtrosHomeStackView: UIStackView!

    var coordinator: DashboardCoordinator?
    var selectedFilters = [UIView]()

    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicatorView.isHidden = true

        if let filters = coordinator?.filters {
            filterCountLabel.text = String(filters.count)

            for filter in filters {
                let button = UIButton() // vamos mudar para uma custom view
                button.setTitle(filter, for: .normal)
                button.layer.borderWidth = 2
                button.layer.borderColor = UIColor.black.cgColor
                button.backgroundColor = UIColor.white
                button.setTitleColor(UIColor.black, for: .normal)
                filtrosHomeStackView.addArrangedSubview(button)
            }

        }
        filterTextField.delegate = self
        filterTextField.becomeFirstResponder()
    }

    @IBAction func goToFilter(_ sender: Any) {
        coordinator?.filtro()
    }

    @IBAction func focusFilterTextField(_ sender: Any) {
        filterTextField.becomeFirstResponder()
    }

    @IBAction func clearFilters(_ sender: Any) {
        coordinator?.filters = []
        filtrosHomeStackView.subviews.forEach {$0.removeFromSuperview()}
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
