//
//  ComicCollectionViewCell.swift
//  Marvel-Swift
//
//  Created by Felipe Silva  on 19/01/20.
//  Copyright © 2020 Felipe Silva . All rights reserved.
//

import UIKit
import SnapKit

final class ComicCollectionViewCell: UICollectionViewCell {
    var image: UIImageView = {
        let image = UIImageView(frame: CGRect(origin: .zero,
                                              size: CGSize(width: 120,
                                                           height: 120)))
        image.layer.cornerRadius = 10
        image.layer.masksToBounds = true
        image.layer.borderWidth = 0.5
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    var label: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 4
        lbl.font = UIFont.boldSystemFont(ofSize: 14)
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    var activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.startAnimating()
        activity.hidesWhenStopped = true
        activity.style = .gray
        activity.color = .black
        activity.translatesAutoresizingMaskIntoConstraints = false
        return activity
    }()

    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.addArrangedSubview(image)
        stackView.addArrangedSubview(label)
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.isBaselineRelativeArrangement = true
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    var viewModel: ObjectCellProtocol? {
        didSet {
            label.text = viewModel?.title
            setupBindings()
        }
    }

    private func setupBindings() {
        guard let viewModel = self.viewModel else {return}

        viewModel.isLoading.bind { [weak self] isLoading in
            guard let self = self else { return }
            isLoading ? self.activityIndicator.startAnimating() : self.activityIndicator.stopAnimating()
        }

        viewModel.image.bind { [weak self] image in
            guard let self = self else { return }
            self.image.image = image
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupCell()
    }

    private func setupCell() {
        addComponents()
        installConstraints()
    }

    private func addComponents() {
        contentView.addSubview(stackView)
        contentView.addSubview(activityIndicator)
    }

    private func installConstraints() {
        stackView.snp.makeConstraints {
            $0.edges.equalTo(self)
        }
        image.snp.makeConstraints {
            $0.height.equalTo(120)
        }
        activityIndicator.snp.makeConstraints {
            $0.center.equalTo(image)
        }
    }
}
