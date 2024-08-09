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
    
    // MARK: - Initialization.
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Method(s).
    func start() {
        navigationController.pushViewController(makeViewController(), animated: true)
    }
    
    func makeViewController() -> DetailViewController {
        let controller = DetailViewController()
        let screen = DetailView()
        
        controller.screen = screen
        return controller
    }
}
