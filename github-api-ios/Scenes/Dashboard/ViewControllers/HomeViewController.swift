//
//  MainViewController.swift
//  github-api-ios
//
//  Created by VICTOR PEREIRA MOURA on 06/12/21.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet var botaoPesquisar: UIButton!
    @IBOutlet var botaoFiltroData: UIView!
    @IBOutlet var botaoFiltroSeguidores: UIView!
    @IBOutlet var botaoFiltroDecrescente: UIView!
    @IBOutlet var filtrarTextField: UITextField!
    @IBOutlet var indicadorDeAtividadeTextBox: UIView!

    @IBOutlet var numeroFiltrosLabel: UILabel!
    var coordinator: DashboardCoordinator?
    var filtrosSelecionados = [UIView]()
    @IBOutlet var filtrosHomeStackView: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()
        indicadorDeAtividadeTextBox.isHidden = true

        if let buttonFilters = coordinator?.filters {
            numeroFiltrosLabel.text = String(buttonFilters.count)

            buttonFilters.forEach {
                $0.addTarget(self, action: #selector(removeFilter), for: .touchUpInside)

                filtrosHomeStackView.addArrangedSubview($0)
                filtrosHomeStackView.setCustomSpacing(8, after: $0)

            }
        }

        filtrarTextField.delegate = self
        filtrarTextField.becomeFirstResponder()
    }

    @IBAction func goToFilter(_ sender: Any) {
        coordinator?.filtro()
    }

//    func carregarFiltrosSelecionados() {
//        for filtro in filtros {
//            filtro.isHidden = !filtrosSelecionados.contains(filtro)
//        }

    @IBAction func limparFiltros(_ sender: UIButton) {
        filtrosSelecionados.removeAll()
//        carregarFiltrosSelecionados()
    }

    @IBAction func focoCampoDeTexto(_ sender: Any) {
        filtrarTextField.becomeFirstResponder()
    }
}

extension HomeViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        indicadorDeAtividadeTextBox.isHidden = false
    }

    func textFieldDidChangeSelection(_ textField: UITextField) {
        indicadorDeAtividadeTextBox.isHidden = false

    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        filtrarTextField.endEditing(true)
        super.touchesBegan(touches, with: event)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        indicadorDeAtividadeTextBox.isHidden = true
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
