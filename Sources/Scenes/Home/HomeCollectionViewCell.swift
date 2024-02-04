//
//  HomeCollectionViewCell.swift
//  MdEditor
//
//  Created by Иван Лясковец on 04.02.2024.
//  Copyright © 2024 LivelockTeam. All rights reserved.
//

import UIKit

// MARK: - HomeCollectionViewCellModel

struct HomeCollectionViewCellModel {
	let title: String
}

// MARK: - Private constants

private enum Constants {
	static let imageViewCornerRadius: CGFloat = 8
	static let imageViewHeight: CGFloat = 150
}

// MARK: - HomeCollectionViewCell

final class HomeCollectionViewCell: UICollectionViewCell {

	static let identifier: String = "collectionViewCell"

	// MARK: - UI

	private var imageView: UIImageView = {
		let imageView = UIImageView(frame: .zero)
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.layer.cornerRadius = Constants.imageViewCornerRadius
		return imageView
	}()

	private var titleLabel: UILabel = {
		let label = UILabel(frame: .zero)
		label.textAlignment = .center
		label.font = UIFont.preferredFont(forTextStyle: .caption1)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	// MARK: - Init

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: Public methods

	func configure(model: HomeCollectionViewCellModel) {
		titleLabel.text = model.title
		imageView.backgroundColor = .gray
	}
}

// MARK: - Private methods

private extension HomeCollectionViewCell {
	func setupView() {
		contentView.backgroundColor = .clear
		contentView.addSubview(imageView)
		contentView.addSubview(titleLabel)
		setupConstraits()
	}

	func setupConstraits() {
		NSLayoutConstraint.activate([
			imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
			imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
			imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
			imageView.heightAnchor.constraint(equalToConstant: Constants.imageViewHeight)
		])

		NSLayoutConstraint.activate([
			titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
			titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
			titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
			titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor)
		])
	}
}
