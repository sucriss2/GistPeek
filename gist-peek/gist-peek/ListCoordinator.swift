//
//  ListCoordinator.swift
//  gist-peek
//
//  Created by Suh on 05/08/24.
//

import UIKit

final class ListCoordinator: Coordinator {
    // MARK: - Property(ies).
    var navigationController: UINavigationController
    var childCoordinator: Coordinator?

    // MARK: - Initialization.
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Method(s).
    func start() {
        navigationController.pushViewController(makeViewController(), animated: true)
    }

    func makeViewController() -> ListViewController {
        let controller = ListViewController()
        let model = ListViewModel()
        let service = ListService()

        controller.model = model
        model.service = service
        model.delegate = controller
        controller.delegate = self

        return controller
    }
}
// MARK: - Extension(s).
extension ListCoordinator: ListViewControllerDelegate {
    func showDetail(detail: Repository) {
        let detailCoordinator = DetailCoordinator(user: detail, navigationController: navigationController)
        detailCoordinator.start()
        childCoordinator = detailCoordinator
    }
}
