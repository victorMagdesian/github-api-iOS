import UIKit

class RepositorioCustomView: UIView {
    @IBOutlet var imageIcon: UIImageView!
    @IBOutlet var repositoryName: UILabel!
    @IBOutlet var stargazingCount: UILabel!
    @IBOutlet var followersCount: UILabel!
    @IBOutlet var forksCount: UILabel!
    @IBOutlet var lastCommitDataInDays: UILabel!
    @IBOutlet var totalStarsLabel: UILabel!

    @IBOutlet var topView: UIView!
    @IBOutlet var bottomView: UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.loadView()
    }

    private func loadView() {

        let bundle = Bundle.init(for: RepositorioCustomView.self)

        if let repositorioXib = bundle.loadNibNamed("RepositorioView", owner: self, options: nil),
           let contentView = repositorioXib.first as? UIView {
            addSubview(contentView)

            contentView.autoresizingMask = [.flexibleWidth, .flexibleRightMargin]
        }

    }

}
