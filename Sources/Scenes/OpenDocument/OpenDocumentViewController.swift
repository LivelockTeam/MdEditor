//
//  OpenDocumentViewController.swift
//  MdEditor
//
//  Created by Sergey Rumyantsev on 01.02.2024.
//  Copyright © 2024 LivelockTeam. All rights reserved.
//

import UIKit

protocol IOpenDocumentViewController: AnyObject {

	/// Метод отрисовки информации на экране.
	/// - Parameter viewModel: данные для отрисовки на экране.
	func render(viewModel: OpenDocumentModel.ViewModel)
}

final class OpenDocumentViewController: UITableViewController {

	// MARK: - Dependencies

	var interactor: IOpenDocumentInteractor?

	// MARK: - Internal properties

	var screenTitle: String

	// MARK: - Private properties

	private var viewModel = OpenDocumentModel.ViewModel(items: [])

	// MARK: - Initialization

	init(screenTitle: String) {
		self.screenTitle = screenTitle
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		interactor?.fetchData()
	}
}

// MARK: - UITableView

extension OpenDocumentViewController {

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.items.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let item = viewModel.items[indexPath.row]
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		configureCell(cell, with: item)
		return cell
	}

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		interactor?.didItemSelected(request: OpenDocumentModel.Request())
	}
}

// MARK: - UI setup

private extension OpenDocumentViewController {

	private func setupUI() {
		view.backgroundColor = UIColor.white
		title = screenTitle
		navigationController?.navigationBar.prefersLargeTitles = false
		self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
	}

	func configureCell(_ cell: UITableViewCell, with item: OpenDocumentModel.ViewModel.Item) {
		var contentConfiguration = cell.defaultContentConfiguration()

		cell.tintColor = UIColor.black
		cell.selectionStyle = .none

		contentConfiguration.image = UIImage(systemName: item.type.rawValue)
		contentConfiguration.text = item.title
		contentConfiguration.secondaryText = item.subTitle

		cell.contentConfiguration = contentConfiguration
	}
}

// MARK: - IMainViewController

extension OpenDocumentViewController: IOpenDocumentViewController {

	/// Метод отрисовки информации на экране.
	/// - Parameter viewModel: данные для отрисовки на экране.
	func render(viewModel: OpenDocumentModel.ViewModel) {
		self.viewModel = viewModel
		tableView.reloadData()
	}
}
