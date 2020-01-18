//
//  NSLayoutConstraintExtension.swift
//  Marvel-Swift
//
//  Created by Felipe Silva  on 18/01/20.
//  Copyright © 2020 Felipe Silva . All rights reserved.
//

import Foundation
import UIKit

extension NSLayoutConstraint {
    @discardableResult
    func activate(priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        self.priority = priority
        self.isActive = true
        return self
    }
}
