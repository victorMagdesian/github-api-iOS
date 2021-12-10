import Foundation
import UIKit

extension FiltroViewController {

    func setUpButton(_ button: UIButton) {
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

    func setButtonSelected(_ button: UIButton) {
        button.isSelected = true

        button.backgroundColor = .black
        button.setTitleColor(.white, for: .selected)
        button.setImage(UIImage(named: "Checked"), for: .normal)

        selectedButtons.append(button)
    }

    func setButtonUnSelected(_ button: UIButton) {
        button.isSelected = false
        button.backgroundColor = .none
        button.setImage(nil, for: .normal)
        button.setTitleColor(.black, for: .normal)
        selectedButtons.remove(at: selectedButtons.firstIndex(of: button)!)
    }

    func selectButtonIfOptionSelected (_ button: UIButton) {
        guard let buttonTitle = button.titleLabel?.text else {
            fatalError()
        }
        if let filters = coordinator?.filters {
            if filters.contains(where: { $0.titleLabel?.text == buttonTitle }) {
                setButtonSelected(button)
            }
        }
    }
}
