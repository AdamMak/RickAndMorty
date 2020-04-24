//
//  SceneDelegate.swift
//  RickAndMorty
//
//  Created by Adam Makhfoudi on 24/04/2020.
//  Copyright © 2020 Adam Makhfoudi. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var coordinator: CharactersCoordinator!

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }

        Theme.applyTheme()

        let window = UIWindow(windowScene: windowScene)
        let navigationController = UINavigationController()
        window.rootViewController = navigationController
        coordinator = CharactersCoordinator(presenter: navigationController)
        coordinator.start()

        window.makeKeyAndVisible()
        self.window = window
    }
}

