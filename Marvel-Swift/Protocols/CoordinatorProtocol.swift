//
//  CoordinatorProtocol.swift
//  Marvel-Swift
//
//  Created by Felipe Silva  on 18/01/20.
//  Copyright © 2020 Felipe Silva . All rights reserved.
//

import UIKit

public protocol RootViewControllerProvider: AnyObject {
    var rootViewController: UIViewController { get }
}

public typealias RootViewCoordinator = Coordinator & RootViewControllerProvider

public protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    func start()
}

public extension Coordinator {
    func addChildCoordinator(_ childCoordinator: Coordinator) {
        self.childCoordinators.append(childCoordinator)
    }

    func removeChildCoordinator(_ childCoordinator: Coordinator) {
        self.childCoordinators = self.childCoordinators.filter {
            $0 !== childCoordinator
        }
    }
}
