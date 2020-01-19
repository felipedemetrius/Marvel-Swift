//
//  CharacterDetailViewController.swift
//  Marvel-Swift
//
//  Created by Felipe Silva  on 19/01/20.
//  Copyright © 2020 Felipe Silva . All rights reserved.
//

import UIKit

final class CharacterDetailViewController: UIViewController {
    var viewModel: CharacterDetailViewProtocol

    init(viewModel: CharacterDetailViewProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        return nil
    }

    lazy var baseView: DetailView = {
        let base = DetailView()
        base.collectionView.delegate = self
        base.collectionView.dataSource = self
        base.collectionView.register(ComicCollectionViewCell.self, forCellWithReuseIdentifier: ComicCollectionViewCell.identifier)

        return base
    }()

    override func loadView() {
        super.loadView()
        self.view = baseView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setViewController()
        setupBindings()
    }

    private func setViewController() {
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        }

        title = viewModel.character.name

        baseView.titleComicsLabel.text = "Participations in comics" + " (\(viewModel.character.comics?.available ?? 0))"

        if let description = viewModel.character.characterDescription, description.trimmingCharacters(in: NSCharacterSet.whitespaces) != "" {
            baseView.descritionLabel.text =  description
        } else {
            baseView.descritionLabel.text =  "Unavailable"
        }
    }

    private func setupBindings() {
        viewModel.isLoading.bind { [weak self] isLoading in
            guard let self = self else { return }
            isLoading ? self.baseView.activityIndicator.startAnimating() : self.baseView.activityIndicator.stopAnimating()
        }

        viewModel.isLoadingNext.bind { [weak self] isLoading in
            guard let self = self else { return }
            isLoading ? self.baseView.activityIndicatorNext.startAnimating() : self.baseView.activityIndicatorNext.stopAnimating()
        }

        viewModel.dataSource.bind { [weak self] _ in
            guard let self = self else { return }
            self.baseView.collectionView.reloadData()
        }

        viewModel.image.bind {  [weak self]  image in
            guard let self = self else { return }
            self.baseView.imageChar.image = image
        }
    }
}

extension CharacterDetailViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let maximumOffset = scrollView.contentSize.width - baseView.collectionView.frame.size.width

        if viewModel.dataSource.value.isEmpty {
            return
        }

        if  maximumOffset - scrollView.contentOffset.x <= 0 {
            if !viewModel.isLoadingNext.value {
                viewModel.nextPage()
            }
        }
    }
}

extension CharacterDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return viewModel.dataSource.value.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ComicCollectionViewCell.identifier, for: indexPath) as? ComicCollectionViewCell else { return UICollectionViewCell() }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

        guard let cell = cell as? ComicCollectionViewCell else { return }
        guard viewModel.dataSource.value.indices.contains(indexPath.row) else { return }
        let object = viewModel.dataSource.value[indexPath.row]

        let viewModel = ObjectCellViewModel(title: object.title ?? "",
                                            urlImage: object.urlImage ?? "")

        cell.viewModel = viewModel
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return !viewModel.dataSource.value.isEmpty ?  CGSize(width: 130, height: 210) : CGSize(width: 0, height: 0)
    }
}
