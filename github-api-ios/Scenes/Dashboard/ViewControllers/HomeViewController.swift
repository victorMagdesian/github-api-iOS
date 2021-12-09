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


        if let buttonFilters = coordinator?.filters {
            numeroFiltrosLabel.text = String(buttonFilters.count)

            buttonFilters.forEach {
                $0.addTarget(self, action: #selector(removeFilter), for: .touchUpInside)

                filtrosHomeStackView.addArrangedSubview($0)
                filtrosHomeStackView.setCustomSpacing(8, after: $0)
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

extension HomeViewController {
    @objc private func removeFilter(_ sender: UIButton) {
        sender.isSelected = false

        guard let indexButton = coordinator?.filters.firstIndex(of: sender) else {
            return
        }

        coordinator?.filters.remove(at: indexButton)

        guard let countFilters = coordinator?.filters.count else { return }

        numeroFiltrosLabel.text = String(countFilters)

        UIView.animate(withDuration: 0.4, delay: 0, options: []) {
            sender.transform = CGAffineTransform(translationX: 0, y: 20)
            sender.alpha = 0
        } completion: { _ in
            sender.removeFromSuperview()
        }
    }
}
