//
//  HomeViewController.swift
//  MdEditor
//
//  Created by Иван Лясковец on 04.02.2024.
//  Copyright © 2024 LivelockTeam. All rights reserved.
//

import UIKit

// MARK: - IHomeViewController

/// Протокол вью главного экрана MdEditor'a.
protocol IHomeViewController: AnyObject {
	/// Метод отрисовки информации на экране.
	/// - Parameter viewModel: Данные для отрисовки на экране.
	func render(viewModel: HomeModel.ViewModel)
}

// MARK: - Constants

private enum Constants {
	static let smallPadding: CGFloat = 8
	static let standartPadding: CGFloat = 16
	static let collectionViewHeight: CGFloat = 180
	static let tableViewCellHeight: CGFloat = 60

	static let tableViewCellIdentifier: String = "cell"
}

// MARK: - HomeViewController

/// Вью главного экрана MdEditor'a.
final class HomeViewController: UIViewController {

	// MARK: - Dependencies

	var interactor: IHomeInteractor?

	// MARK: - UI

	private lazy var collectionView: UICollectionView = {
		// Flow
		let flowLayout = UICollectionViewFlowLayout()
		flowLayout.scrollDirection = .horizontal
		flowLayout.itemSize = CGSize(width: 90, height: 170)
		flowLayout.sectionInset = UIEdgeInsets(top: 16, left: 8, bottom: 16, right: 8)
		// Collection
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
		collectionView.dataSource = self
		collectionView.delegate = self
		collectionView.showsHorizontalScrollIndicator = false
		collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		return collectionView
	}()

	private lazy var tableView: UITableView = {
		let tableView = UITableView(frame: .zero)
		tableView.backgroundColor = .clear
		tableView.dataSource = self
		tableView.delegate = self
		tableView.separatorStyle = .none
		tableView.isScrollEnabled = false
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.tableViewCellIdentifier)
		tableView.translatesAutoresizingMaskIntoConstraints = false
		return tableView
	}()

	// MARK: - Private properties

	private var viewModel = HomeModel.ViewModel(
		menuPoints: [
			HomeModel.ViewModel.MenuPoint(title: L10n.Home.newDocument, image: UIImage(systemName: "doc")),
			HomeModel.ViewModel.MenuPoint(title: L10n.Home.openDocument, image: UIImage(systemName: "folder")),
			HomeModel.ViewModel.MenuPoint(title: L10n.Home.about, image: UIImage(systemName: "info.circle"))
		],
		documents: [
			HomeModel.ViewModel.MdDocument(title: "about.md", backgroundColor: .yellow),
			HomeModel.ViewModel.MdDocument(title: "ascii.md", backgroundColor: .blue),
			HomeModel.ViewModel.MdDocument(title: "utm.md", backgroundColor: .brown),
			HomeModel.ViewModel.MdDocument(title: "test.md", backgroundColor: .gray),
			HomeModel.ViewModel.MdDocument(title: "test.md", backgroundColor: .green)
		]
	)

	// MARK: - Init

	init() {
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - LifeCycle

	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		#warning("TODO: Обработать загрузку данных")
		// interactor?.fetchData()
	}
}

// MARK: - IMainViewController

extension HomeViewController: IHomeViewController {
	/// Метод отрисовки информации на экране.
	/// - Parameter viewModel: данные для отрисовки на экране.
	func render(viewModel: HomeModel.ViewModel) {
		self.viewModel = viewModel
		collectionView.reloadData()
		tableView.reloadData()
	}
}

// MARK: - UITableViewDataSource

extension HomeViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		viewModel.menuPoints.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let menuPoint = getMenuPointForIndex(indexPath)
		let cell = tableView.dequeueReusableCell(withIdentifier: Constants.tableViewCellIdentifier, for: indexPath)
		configureCell(cell, with: menuPoint)
		return cell
	}
}

// MARK: - UITableViewDelegate

extension HomeViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return Constants.tableViewCellHeight
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		#warning("TODO: Обработать нажатие на кнопку меню")
		// interactor?.didTaskSelected(request: TodoListModel.Request.TaskSelected(indexPath: indexPath))
	}
}

// MARK: - UICollectionViewDataSource

extension HomeViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		viewModel.documents.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(
			withReuseIdentifier: HomeCollectionViewCell.identifier,
			for: indexPath
		) as? HomeCollectionViewCell else { return UICollectionViewCell() }
		let document = viewModel.documents[indexPath.item]
		let model = HomeCollectionViewCellModel(title: document.title, color: document.backgroundColor)
		cell.configure(model: model)
		return cell
	}
}

// MARK: - UICollectionViewDelegate

extension HomeViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		#warning("TODO: Обработать нажатие по документу")
		// print(indexPath.item)
	}
}

// MARK: - Private methods

private extension HomeViewController {
	func setupView() {
		title = L10n.Home.title
		view.backgroundColor = .white
		navigationController?.navigationBar.prefersLargeTitles = true

		view.addSubview(collectionView)
		view.addSubview(tableView)
		setupConstraits()
	}

	func setupConstraits() {
		NSLayoutConstraint.activate([
			collectionView.topAnchor.constraint(
				equalTo: view.safeAreaLayoutGuide.topAnchor,
				constant: Constants.standartPadding
			),
			collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
			collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
			collectionView.heightAnchor.constraint(equalToConstant: Constants.collectionViewHeight)
		])

		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: Constants.standartPadding),
			tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
			tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
		])
	}

	func getMenuPointForIndex(_ indexPath: IndexPath) -> HomeModel.ViewModel.MenuPoint {
		let menuPoints = viewModel.menuPoints
		let menuPoint = menuPoints[indexPath.row]
		return menuPoint
	}

	func configureCell(_ cell: UITableViewCell, with menuPoint: HomeModel.ViewModel.MenuPoint) {
		cell.selectionStyle = .none

		var contentConfiguration = cell.defaultContentConfiguration()
		contentConfiguration.attributedText = NSAttributedString(string: menuPoint.title)
		contentConfiguration.image = menuPoint.image
		cell.contentConfiguration = contentConfiguration
	}
}
