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
		let viewModel = OpenDocumentModel.ViewModel(items: itemParser(folderItems: response))
		viewController.render(viewModel: viewModel)
	}

	// MARK: - Private methods
	private func itemParser(folderItems: OpenDocumentModel.Response) -> [OpenDocumentModel.ViewModel.Item] {
		var items: [OpenDocumentModel.ViewModel.Item] = []

		for folder in folderItems.folders {
			let item = OpenDocumentModel.ViewModel.Item(
				icon: .folder,
				title: folder.name,
				subTitle: getFormattedAttributes(folder: folder)
			)
			items.append(item)
		}

		for file in folderItems.files {
			let item = OpenDocumentModel.ViewModel.Item(
				icon: .file,
				title: file.name,
				subTitle: getFormattedAttributes(file: file)
			)
			items.append(item)
		}

		return items
	}

	private func getFormattedAttributes(folder: Folder) -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy.MM.dd HH:mm:ss"

		return "\(dateFormatter.string(from: folder.modificationDate)) | <dir>"
	}

	private func getFormattedAttributes(file: File) -> String {
		let formattedSize = file.getFormattedSize()
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy.MM.dd HH:mm:ss"

		return "\"\(file.ext)\" – \(dateFormatter.string(from: file.modificationDate)) | \(formattedSize)"
	}
}
