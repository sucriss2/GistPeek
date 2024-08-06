//
//  Coordinator.swift
//  gist-peek
//
//  Created by Suh on 05/08/24.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}
