//
//  AppCoordinator.swift
//  Marvel-Swift
//
//  Created by Felipe Silva  on 18/01/20.
//  Copyright © 2020 Felipe Silva . All rights reserved.
//

import UIKit
import SDKMarvel

class AppCoordinator: RootViewCoordinator {
    let window: UIWindow
    var childCoordinators: [Coordinator] = []
    var rootViewController: UIViewController {
        return self.navigationController
    }
    lazy var navigationController: UINavigationController = {
        let navigationController = NavigationController()
        return navigationController
    }()
    init(window: UIWindow) {
        self.window = window
        self.window.rootViewController = self.rootViewController
        self.window.makeKeyAndVisible()
    }
    func start() {
        let viewModel = CharactersViewModel(navigationDelegate: self)
        let viewController = CharactersViewController(viewModel: viewModel)
        self.navigationController.viewControllers = [viewController]
    }
}

extension AppCoordinator: CharactersNavigationProtocol {
    func goToCharacterDetail(character: Character) {
        print(character)
    }
}
