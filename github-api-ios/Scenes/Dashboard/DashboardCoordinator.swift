import Foundation
import UIKit

class DashboardCoordinator: Coordinator {

    weak var parentCoordinator: AppCoordinator?
    var navigationController: UINavigationController?

    var filters: [String]?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

//     ViewModel aqui
    override func start() {
        let viewCont = HomeViewController()
        viewCont.coordinator = self
        navigationController!.pushViewController(viewCont, animated: true)
    }

    func filtro() {
        let viewCont = FiltroViewController()
        viewCont.coordinator = self
        // viewCont.coordinator?.navigationController = self.navigationController
        navigationController!.pushViewController(viewCont, animated: true)
    }

    func details() {
        let viewCont = DetalheViewController()
        viewCont.coordinator = self
        navigationController!.pushViewController(viewCont, animated: true)
    }

    func applyFilters(filters: [String]) {
        self.filters?.append(contentsOf: filters)
    }

    func sendBackToHome() {
        start()
    }

    override func finish() {
    }

}
