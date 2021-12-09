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

        if let filtros = coordinator?.filters {
            numeroFiltrosLabel.text = String(filtros.count)

            for filtro in filtros {
                let button = UIButton() // vamos mudar para uma custom view
                button.setTitle(filtro, for: .normal)
                button.layer.borderWidth = 2
                button.layer.borderColor = UIColor.black.cgColor
                filtrosHomeStackView.addArrangedSubview(button)

            }

        }
        filtrarTextField.delegate = self
        filtrarTextField.becomeFirstResponder()

//        loadButton()
    }

    func abrirfiltro() {

    }

    @IBAction func goToFilter(_ sender: Any) {
        coordinator?.filtro()
    }

//    func carregarFiltrosSelecionados() {
//        for filtro in filtros {
//            filtro.isHidden = !filtrosSelecionados.contains(filtro)
//        }


    @IBAction func limparFiltros(_ sender: UIButton) {
        filtrosSelecionados = []
//        carregarFiltrosSelecionados()
    }

    @IBAction func focoCampoDeTexto(_ sender: Any) {
        filtrarTextField.becomeFirstResponder()
    }

//    func loadButton() {
//        let buttonView = CustomFilterButton()
//
//        self.container.addSubview(buttonView)
//        buttonView.frame = self.container.bounds
//    }
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
