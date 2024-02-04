//
//  HomeCollectionViewCell.swift
//  MdEditor
//
//  Created by Иван Лясковец on 04.02.2024.
//  Copyright © 2024 LivelockTeam. All rights reserved.
//

import UIKit

struct HomeCollectionViewCellModel {
	let title: String
	let color: UIColor?
}

final class HomeCollectionViewCell: UICollectionViewCell {

	static let identifier: String = "collectionViewCell"

	// MARK: - UI

	private var imageView: UIImageView = {
		let imageView = UIImageView(frame: .zero)
		imageView.contentMode = .scaleAspectFill
		imageView.backgroundColor = .blue
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()

	private var titleLabel: UILabel = {
		let label = UILabel(frame: .zero)
		label.textAlignment = .center
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
		imageView.backgroundColor = model.color
	}
}

// MARK: - Private methods

private extension HomeCollectionViewCell {
	func setupView() {
		contentView.backgroundColor = .red
		contentView.addSubview(imageView)
		contentView.addSubview(titleLabel)
		layer.cornerRadius = 8
		setupConstraits()
	}

	func setupConstraits() {
		NSLayoutConstraint.activate([
			imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
			imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
			imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
			imageView.heightAnchor.constraint(equalToConstant: 120)
		])

		NSLayoutConstraint.activate([
			titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
			titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
			titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
			titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20)
		])
	}
}
