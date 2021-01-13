//
//  CharactersViewController.swift
//  Marvel-Swift
//
//  Created by Felipe Silva  on 18/01/20.
//  Copyright © 2020 Felipe Silva . All rights reserved.
//

import UIKit

final class CharactersViewController: UIViewController {
    private let viewModel: CharactersViewProtocol

    init(viewModel: CharactersViewProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        return nil
    }

    lazy var baseView: ListView = {
        let base = ListView()
        base.tableView.separatorStyle = .none
        base.tableView.register(CharCell.self, forCellReuseIdentifier: CharCell.identifier)
        base.tableView.rowHeight = 100
        base.tableView.delegate = self
        base.tableView.dataSource = self

        base.refreshControl.addTarget(viewModel, action: #selector(CharactersViewModel.pullRefresh), for: UIControl.Event.valueChanged)
        return base
    }()

    override func loadView() {
        super.loadView()
        self.view = baseView
    }

    override  func viewDidLoad() {
        super.viewDidLoad()

        setViewController()
        setupBindings()
    }

    private func setViewController() {
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        }
        title = viewModel.title
    }

    private func setupBindings() {
        viewModel.isLoading.bind { [weak self] isLoading in
            guard let self = self else { return }
            if isLoading {
                self.baseView.activityIndicator.startAnimating()
            } else {
                self.baseView.activityIndicator.stopAnimating()
                self.baseView.refreshControl.endRefreshing()
            }
        }

        viewModel.isLoadingNext.bind { [weak self] isLoading in
            guard let self = self else { return }
            isLoading ? self.baseView.activityIndicatorNext.startAnimating() : self.baseView.activityIndicatorNext.stopAnimating()
        }

        viewModel.error.bind { [weak self] errorMessage in
            guard let self = self else { return }
            if let error = errorMessage {
                self.baseView.labelMessage.isHidden = false
                self.baseView.labelMessage.text = error
            } else {
                self.baseView.labelMessage.isHidden = true
            }
        }

        viewModel.dataSource.bind { [weak self] chars in
            guard let self = self else { return }
            if chars.isEmpty {
                self.baseView.tableView.separatorStyle = .none
            } else {
                self.baseView.tableView.separatorStyle = .singleLine
            }
            self.baseView.tableView.reloadData()
        }
    }

    override  func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - UIScrollViewDelegate
extension CharactersViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let maximumOffset = scrollView.contentSize.height - baseView.tableView.frame.size.height

        if viewModel.dataSource.value.isEmpty {
            return
        }

        if  maximumOffset - scrollView.contentOffset.y <= 0 {
            if !viewModel.isLoadingNext.value {
                viewModel.nextPage()
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension CharactersViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSource.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharCell.identifier,
            for: indexPath) as? CharCell else { return UITableViewCell() }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRowAt(row: indexPath.row)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? CharCell else { return }
        guard viewModel.dataSource.value.indices.contains(indexPath.row) else { return }
        let char = viewModel.dataSource.value[indexPath.row]

        let viewModel = ObjectCellViewModel(title: char.name ?? "",
                                           urlImage: char.urlImage ?? "")

        cell.viewModel = viewModel
    }
}
