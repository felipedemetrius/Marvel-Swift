//
//  ListView.swift
//  Marvel-Swift
//
//  Created by Felipe Silva  on 18/01/20.
//  Copyright © 2020 Felipe Silva . All rights reserved.
//

import Foundation
import UIKit
import SnapKit

final class ListView: UIView {
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .white
        table.tableFooterView = UIView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    var activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.startAnimating()
        activity.hidesWhenStopped = true
        activity.style = .whiteLarge
        activity.color = .black
        return activity
    }()

    var activityIndicatorNext: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.hidesWhenStopped = true
        activity.style = .gray
        activity.color = .black
        return activity
    }()

    var labelMessage: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    var refreshControl = UIRefreshControl()

    init() {
        super.init(frame: .zero)
        addComponents()
        addPullToRefresh()
        installConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addComponents() {
        addSubview(tableView)
        addSubview(labelMessage)
        addSubview(activityIndicator)
        addSubview(activityIndicatorNext)
    }

    private func installConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        labelMessage.snp.makeConstraints {
            $0.center.equalTo(self)
            $0.right.greaterThanOrEqualTo(self).inset(16)
            $0.left.greaterThanOrEqualTo(self).inset(16)
        }
        activityIndicator.snp.makeConstraints {
            $0.center.equalTo(self)
        }
        activityIndicatorNext.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }

    @objc private func addPullToRefresh() {
        refreshControl.tintColor = UIColor.white
        tableView.addSubview(refreshControl)
    }
}
