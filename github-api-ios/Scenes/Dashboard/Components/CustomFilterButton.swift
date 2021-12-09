import Foundation
import UIKit

class CustomFilterButton: UIView {
    @IBOutlet var filterButton: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }

    private func commonInit() {
        let bundle = Bundle.init(for: CustomFilterButton.self)

        if let viewToAdd = bundle.loadNibNamed("CustomFilterButton", owner: self, options: nil),
           let contentView = viewToAdd.first as? UIView {
            addSubview(contentView)
            contentView.frame = self.bounds
        }
    }
}
