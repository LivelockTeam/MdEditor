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
//		// TEST DATA ↓
//		let viewModel = OpenDocumentModel.ViewModel(
//			items: [
//				OpenDocumentModel.ViewModel.Item(
//					type: OpenDocumentModel.ViewModel.ItemType.folder,
//					title: "Test1",
//					subTitle: "test1"
//				),
//				OpenDocumentModel.ViewModel.Item(
//					type: OpenDocumentModel.ViewModel.ItemType.folder,
//					title: "Test2",
//					subTitle: "test2"
//				),
//				OpenDocumentModel.ViewModel.Item(
//					type: OpenDocumentModel.ViewModel.ItemType.file,
//					title: "Test3",
//					subTitle: "test3"
//				)
//			]
//		)
//		// TEST DATA ↑

		let viewModel = OpenDocumentModel.ViewModel(items: itemParser(files: response.items))
		viewController.render(viewModel: viewModel)
	}

	// MARK: - Private methods
	private func itemParser(files: [File]) -> [OpenDocumentModel.ViewModel.Item] {
		var items: [OpenDocumentModel.ViewModel.Item] = []

		for file in files {
			let type = file.isDir ? OpenDocumentModel.ViewModel.ItemType.folder : OpenDocumentModel.ViewModel.ItemType.file
			let item = OpenDocumentModel.ViewModel.Item(
				type: type,
				title: file.name,
				subTitle: file.getFormattedAttributes()
			)
			items.append(item)
		}

		return items
	}
}
