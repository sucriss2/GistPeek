//
//  UIViewController+Extensions.swift
//  gist-peek
//
//  Created by Suh on 09/08/24.
//

import UIKit

extension UIViewController {
    func showLoading() {
        let viewController = LoadingViewController()
        viewController.modalPresentationStyle = .overFullScreen
        present(viewController, animated: false)
    }

    func hideLoading() {
        guard let viewController = presentedViewController as? LoadingViewController else {
            return
        }

        viewController.dismiss(animated: false)
    }
}
