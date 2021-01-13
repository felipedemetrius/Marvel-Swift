//
//  SnapshotTestCase.swift
//  Marvel-SwiftTests
//
//  Created by Felipe Silva on 13/01/21.
//  Copyright © 2021 Felipe Silva . All rights reserved.
//

import SnapshotTesting
import UIKit
import XCTest

class SnapshotTestCase: XCTestCase {
    var record = false

    func snapshot(matching: () -> UIViewController, wait: TimeInterval? = nil, viewHeight: CGFloat? = nil, file: StaticString = #file, testName: String = #function, line: UInt = #line) {
        let vc = { () -> UIViewController in
            let navigationController = UINavigationController(rootViewController: matching())
            return navigationController
        }

        assertDefaultSnapshot(matching: vc, wait: wait, viewHeight: viewHeight, file: file, testName: testName, line: line)
    }
    
    private func assertDefaultSnapshot(matching value: () -> UIViewController, wait: TimeInterval? = nil, viewHeight: CGFloat? = nil, file: StaticString = #file, testName: String = #function, line: UInt = #line) {
        let scale = "\(UIScreen.main.scale)".prefix(1)
        let iOS = UIDevice.current.systemVersion.substring(to: ".")

        var iphoneXr = Snapshotting.image(on: .iPhoneXr)
        var iPhoneSe = Snapshotting.image(on: .iPhoneSe)
        var recursiveDescription = Snapshotting.recursiveDescription(on: .iPhoneXr)

        if let wait = wait {
            iphoneXr = .wait(for: wait, on: iphoneXr)
            iPhoneSe = .wait(for: wait, on: iPhoneSe)
            recursiveDescription = .wait(for: wait, on: recursiveDescription)
        }

        assertSnapshot(matching: value(), as: iphoneXr, named: "iPhoneXr(\(iOS))@\(scale)x", record: record, file: file, testName: testName, line: line)
        assertSnapshot(matching: value(), as: iPhoneSe, named: "iPhoneSe(\(iOS))@\(scale)x", record: record, file: file, testName: testName, line: line)
        assertSnapshot(matching: value(), as: recursiveDescription, record: record, file: file, testName: testName, line: line)

        if let viewHeight = viewHeight {
            var customHeight = Snapshotting.image(on: .init(safeArea: UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0), size: CGSize(width: 320, height: viewHeight), traits: .init()))

            if let wait = wait { customHeight = .wait(for: wait, on: customHeight) }

            assertSnapshot(matching: value(),
                           as: customHeight,
                           named: "customHeight(\(iOS))@\(scale)x",
                           record: record,
                           file: file,
                           testName: testName,
                           line: line)
        }
    }

}


extension String {
    func substring(to: String) -> String {
           if let index = range(of: to) {
               return String(self[..<index.lowerBound])
           }
           return self
       }
}
