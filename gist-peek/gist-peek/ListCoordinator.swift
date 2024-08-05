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
        return controller
    }
}
