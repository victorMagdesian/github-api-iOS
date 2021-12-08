//
//  MainViewController.swift
//  github-api-ios
//
//  Created by VICTOR PEREIRA MOURA on 06/12/21.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet var botaoNumeroNotificacoes: UIButton!
    @IBOutlet var botaoPesquisar: UIButton!
    @IBOutlet var botaoFiltroData: UIView!
    @IBOutlet var botaoFiltroSeguidores: UIView!
    @IBOutlet var botaoFiltroDecrescente: UIView!
    @IBOutlet var filtrarTextField: UITextField!
    @IBOutlet var indicadorDeAtividadeTextBox: UIView!

    var coordinator: DashboardCoordinator?

    var filtros = [UIView]()
    var filtrosSelecionados = [UIView]()

    override func viewDidLoad() {
        print("Entrou aqui dnv")
        indicadorDeAtividadeTextBox.isHidden = true
        super.viewDidLoad()

        filtros = [
            self.botaoFiltroData,
            self.botaoFiltroSeguidores,
            self.botaoFiltroDecrescente
        ]
        filtrosSelecionados = filtros

        for filtro in filtros {

        }
        filtrarTextField.delegate = self
        filtrarTextField.becomeFirstResponder()
    }

    func abrirfiltro() {

    }

    @IBAction func goToFilter(_ sender: Any) {
        coordinator?.filtro()
    }

    func carregarFiltrosSelecionados() {
        for filtro in filtros {
            filtro.isHidden = !filtrosSelecionados.contains(filtro)
        }
    }

    @IBAction func limparFiltros(_ sender: UIButton) {
        filtrosSelecionados = []
        carregarFiltrosSelecionados()
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
