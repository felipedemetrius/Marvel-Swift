//
//  DetailView.swift
//  Marvel-Swift
//
//  Created by Felipe Silva  on 19/01/20.
//  Copyright © 2020 Felipe Silva . All rights reserved.
//

import UIKit
import SnapKit

final class DetailView: UIView {
    var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.backgroundColor = .white
        return scroll
    }()

    var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var imageChar: UIImageView = {
        let image = UIImageView(frame: CGRect(origin: .zero,
                                              size: CGSize(width: 280,
                                                           height: 280)))
        image.layer.cornerRadius = image.frame.width / 2
        image.layer.masksToBounds = true
        image.layer.borderWidth = 0.5
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    var titleDescriptionLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 17.0)
        lbl.text = "Description"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    var descritionLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    var titleComicsLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 17.0)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 30
        flowLayout.minimumLineSpacing = 30
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = true
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = true
        collectionView.clipsToBounds = true

        collectionView.layer.cornerRadius = 4
        return collectionView
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

    init() {
        super.init(frame: .zero)
        addComponents()
        installConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addComponents() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(imageChar)
        contentView.addSubview(titleDescriptionLabel)
        contentView.addSubview(descritionLabel)
        contentView.addSubview(titleComicsLabel)
        contentView.addSubview(collectionView)
        contentView.addSubview(activityIndicator)
        contentView.addSubview(activityIndicatorNext)
    }

    private func installConstraints() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(scrollView)
        }
        imageChar.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top).offset(20)
            $0.height.equalTo(280)
            $0.width.equalTo(280)
            $0.centerX.equalToSuperview()
        }
        titleDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(imageChar.snp.bottom).offset(20)
            $0.left.equalTo(contentView).inset(16)
            $0.right.equalTo(contentView).inset(16)
        }
        descritionLabel.snp.makeConstraints {
            $0.top.equalTo(titleDescriptionLabel.snp.bottom).offset(6)
            $0.left.equalTo(contentView).inset(16)
            $0.right.equalTo(contentView).inset(16)
        }
        titleComicsLabel.snp.makeConstraints {
            $0.top.equalTo(descritionLabel.snp.bottom).offset(20)
            $0.left.equalTo(contentView).inset(16)
            $0.right.equalTo(contentView).inset(16)
        }
        collectionView.snp.makeConstraints {
            $0.top.equalTo(titleComicsLabel.snp.bottom).offset(6)
            $0.left.equalTo(contentView).inset(8)
            $0.right.equalTo(contentView).inset(0)
            $0.bottom.equalTo(contentView).inset(60)
            $0.height.equalTo(220)
        }
        activityIndicator.snp.makeConstraints {
            $0.center.equalTo(collectionView.snp.center)
        }
        activityIndicatorNext.snp.makeConstraints {
            $0.centerY.equalTo(activityIndicator.snp.centerY)
            $0.trailing.equalToSuperview()
        }
    }
}
