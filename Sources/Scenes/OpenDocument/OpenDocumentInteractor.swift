//
//  OpenDocumentInteractor.swift
//  MdEditor
//
//  Created by Sergey Rumyantsev on 01.02.2024.
//  Copyright © 2024 LivelockTeam. All rights reserved.
//

import Foundation

protocol IOpenDocumentInteractor {
	func fetchData()
	func didItemSelected(request: OpenDocumentModel.Request)
}

typealias OpenDocumentResultClosure = (ItemType) -> Void

final class OpenDocumentInteractor: IOpenDocumentInteractor {

	// MARK: - Dependencies

	private var presenter: IOpenDocumentPresenter
	private var worker: IOpenDocumentWorker
	private var openDocumentResultClosure: OpenDocumentResultClosure?

	// MARK: - Initialization

	init(
		presenter: IOpenDocumentPresenter,
		worker: IOpenDocumentWorker,
		openDocumentResultClosure: OpenDocumentResultClosure?
	) {
		self.presenter = presenter
		self.worker = worker
		self.openDocumentResultClosure = openDocumentResultClosure
	}

	// MARK: - Public methods

	/// Событие на предоставление информации для списка папок и файлов.
	func fetchData() {
		let items = worker.getFoldersAndFiles()
		let response = OpenDocumentModel.Response(items: items)
		presenter.present(response: response)
	}

	/// Событие, что папка или файл были выбраны.
	/// - Parameter request: Запрос, содержащий информацию о выбранном элементе.
	func didItemSelected(request: OpenDocumentModel.Request) {
		var item: ItemType
		switch request.type {
		case .folder:
			item = .folder(ItemType.Folder(title: request.title, path: request.path))
		case .file:
			item = .file(ItemType.File(path: request.path))
		}
		openDocumentResultClosure?(item)
	}
}

enum ItemType {
	case folder(Folder)
	case file(File)

	struct Folder {
		let title: String
		let path: String
	}

	struct File {
		let path: String
	}
}
