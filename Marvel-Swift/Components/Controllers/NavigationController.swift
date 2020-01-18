//
//  NavigationController.swift
//  Marvel-Swift
//
//  Created by Felipe Silva  on 18/01/20.
//  Copyright © 2020 Felipe Silva . All rights reserved.
//

import UIKit

final class NavigationController: UINavigationController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }

    override func loadView() {
        super.loadView()
        configureNavigation()
    }

    private func configureNavigation() {
        navigationBar.isTranslucent = false
        navigationBar.barTintColor = .white
        navigationBar.tintColor = .white
        navigationBar.backgroundColor = .white
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .title2)]

        if #available(iOS 11.0, *) {
            navigationBar.prefersLargeTitles = true
        }
    }
}
