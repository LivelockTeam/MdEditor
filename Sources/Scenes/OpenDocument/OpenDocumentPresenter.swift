//
//  OpenDocumentPresenter.swift
//  MdEditor
//
//  Created by Sergey Rumyantsev on 01.02.2024.
//  Copyright © 2024 LivelockTeam. All rights reserved.
//

import Foundation

protocol IOpenDocumentPresenter {

	/// Отображение экрана со списком папок и файлов.
	/// - Parameter response: Подготовленные к отображению данные.
	func present(response: OpenDocumentModel.Response)
}

final class OpenDocumentPresenter: IOpenDocumentPresenter {

	// MARK: - Dependencies

	private weak var viewController: IOpenDocumentViewController! // swiftlint:disable:this implicitly_unwrapped_optional

	// MARK: - Initialization

	init(viewController: IOpenDocumentViewController) {
		self.viewController = viewController
	}

	// MARK: - Public methods

	func present(response: OpenDocumentModel.Response) {
		// Обрабатываем данные от OpenDocumentInteractor
		// передаём их в подготовленном виде в OpenDocumentViewController

		// TEST DATA ↓
		let viewModel = OpenDocumentModel.ViewModel(
			items: [
				OpenDocumentModel.ViewModel.Item(
					type: OpenDocumentModel.ViewModel.ItemType.folder,
					title: "Test1",
					subTitle: "test1"
				),
				OpenDocumentModel.ViewModel.Item(
					type: OpenDocumentModel.ViewModel.ItemType.folder,
					title: "Test2",
					subTitle: "test2"
				),
				OpenDocumentModel.ViewModel.Item(
					type: OpenDocumentModel.ViewModel.ItemType.file,
					title: "Test3",
					subTitle: "test3"
				)
			]
		)
		// TEST DATA ↑

		viewController.render(viewModel: viewModel)
	}
}
