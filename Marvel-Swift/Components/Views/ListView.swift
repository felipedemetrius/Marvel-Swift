//
//  ListView.swift
//  Marvel-Swift
//
//  Created by Felipe Silva  on 18/01/20.
//  Copyright © 2020 Felipe Silva . All rights reserved.
//

import Foundation
import UIKit

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
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).activate()
        tableView.topAnchor.constraint(equalTo: self.topAnchor).activate()
        tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).activate()
        tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).activate()

        labelMessage.centerXAnchor.constraint(equalTo: self.centerXAnchor).activate()
        labelMessage.centerYAnchor.constraint(equalTo: self.centerYAnchor).activate()
        labelMessage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 16).activate()
        labelMessage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).activate()

        activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).activate()
        activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).activate()
        
        activityIndicatorNext.centerXAnchor.constraint(equalTo: self.centerXAnchor).activate()
        activityIndicatorNext.bottomAnchor.constraint(equalTo: self.bottomAnchor).activate()
    }

    @objc private func addPullToRefresh() {
        refreshControl.tintColor = UIColor.white
        tableView.addSubview(refreshControl)
    }
}
