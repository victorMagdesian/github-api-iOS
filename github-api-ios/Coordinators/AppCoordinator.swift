import Foundation
import UIKit

class AppCoordinator: Coordinator {
    let window: UIWindow?

    lazy var rootViewController: UIViewController = {
        return FiltroViewController()
    }()

    init(window: UIWindow?) {
        self.window = window
    }

    override func start() {
        guard let window = window else { return }

        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }

    override func finish() { }
}
