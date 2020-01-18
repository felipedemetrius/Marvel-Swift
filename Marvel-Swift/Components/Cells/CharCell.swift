//
//  CharCell.swift
//  Marvel-Swift
//
//  Created by Felipe Silva  on 18/01/20.
//  Copyright © 2020 Felipe Silva . All rights reserved.
//

import UIKit

final class CharCell: UITableViewCell {
    var imageChar: UIImageView = {
        let image = UIImageView(frame: CGRect(origin: .zero,
                                              size: CGSize(width: 70,
                                                           height: 70)))
        image.layer.cornerRadius = image.frame.width / 2
        image.layer.masksToBounds = true
        image.layer.borderWidth = 0.5
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    lazy var label: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
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
        stackView.addArrangedSubview(imageChar)
        stackView.addArrangedSubview(label)
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupCell()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
            self.imageChar.image = image
        }
    }

    private func setupCell() {
        self.selectionStyle = .none
        self.accessoryType = .disclosureIndicator
        addComponents()
        installConstraints()
    }

    private func addComponents() {
        contentView.addSubview(stackView)
        contentView.addSubview(activityIndicator)
    }

    private func installConstraints() {
        stackView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor).activate()
        stackView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor).activate()
        stackView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor).activate()
        stackView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor).activate()
        
        activityIndicator.centerYAnchor.constraint(equalTo: imageChar.centerYAnchor).activate()
        activityIndicator.centerXAnchor.constraint(equalTo: imageChar.centerXAnchor).activate()
        
        imageChar.heightAnchor.constraint(equalToConstant: 70).activate()
        imageChar.widthAnchor.constraint(equalToConstant: 70).activate()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
