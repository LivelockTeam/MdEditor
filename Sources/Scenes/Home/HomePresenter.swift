//
//  HomePresenter.swift
//  MdEditor
//
//  Created by Иван Лясковец on 04.02.2024.
//  Copyright © 2024 LivelockTeam. All rights reserved.
//

import Foundation

/// Протокол презентера главного экрана MdEditor'a.
protocol IHomePresenter {
	/// Отображение главного экрана.
	/// - Parameter response: Подготовленные к отображению данные.
	func present(responce: HomeModel.Response)
}

/// Презентер главного экрана MdEditor'a.
final class HomePresenter: IHomePresenter {

	// MARK: - Dependencies

	private weak var viewController: IHomeViewController?

	// MARK: - Initialization

	init(viewController: IHomeViewController?) {
		self.viewController = viewController
	}

	// MARK: - Public methods

	/// Отображение главного экрана.
	/// - Parameter response: Подготовленные к отображению данные.
	func present(responce: HomeModel.Response) {
		let viewModel = HomeModel.ViewModel(
			menuPoints: convertMenu(response: responce),
			documents: convertDocuments(response: responce)
		)
		viewController?.render(viewModel: viewModel)
	}
}

// MARK: - Private methods

private extension HomePresenter {
	func convertMenu(response: HomeModel.Response) -> [HomeModel.ViewModel.MenuPoint] {
		let result = response.menu.map { item in
			return HomeModel.ViewModel.MenuPoint(title: item.title, image: item.image)
		}
		return result
	}

	func convertDocuments(response: HomeModel.Response) -> [HomeModel.ViewModel.MdDocument] {
		let result = response.documents.map { item in
			return HomeModel.ViewModel.MdDocument(title: item.title)
		}
		return result
	}
}
