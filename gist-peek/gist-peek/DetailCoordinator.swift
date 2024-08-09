//
//  DetailCoordinator.swift
//  gist-peek
//
//  Created by Suh on 08/08/24.
//

import UIKit

final class DetailCoordinator: Coordinator {
    // MARK: - Property(ies).
    var navigationController: UINavigationController
    private var user: Repository

    // MARK: - Initialization.
    init(user: Repository, navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.user = user
    }

    // MARK: - Method(s).
    func start() {
        navigationController.pushViewController(makeViewController(), animated: true)
    }

    func makeViewController() -> DetailViewController {
        let controller = DetailViewController()
        let screen = DetailView()
        let model = DetailModel(user: user)

        controller.screen = screen
        controller.model = model
        return controller
    }
}
