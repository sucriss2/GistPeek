//
//  AppCoordinator.swift
//  gist-peek
//
//  Created by Suh on 05/08/24.
//

import UIKit

final class AppCoordinator: Coordinator {
    // MARK: - Property(ies).
    var navigationController: UINavigationController
    private var listCoordinator: ListCoordinator?
    var window: UIWindow?

    // MARK: - Initialization.
    init(window: UIWindow?) {
        navigationController = UINavigationController()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        self.window = window
    }

    // MARK: - Method(s).
    func start() {
        showLogin()
    }
    
    private func showLogin() {
        let coordinator = ListCoordinator(navigationController: navigationController)
        coordinator.start()
        self.listCoordinator = coordinator
    }
}
