//
//  SceneDelegate.swift
//  gist-peek
//
//  Created by Suh on 05/08/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        let controller = ViewController()
        window.rootViewController = controller
        
        self.window = window
        window.makeKeyAndVisible()
    }
}

