//
//  OpenDocumentAssembler.swift
//  MdEditor
//
//  Created by Sergey Rumyantsev on 01.02.2024.
//  Copyright © 2024 LivelockTeam. All rights reserved.
//

import Foundation

final class OpenDocumentAssembler {

	/// Сборка модуля авторизации
	/// - Parameter openDocumentResultClosure: замыкание возвращающее URL открываемого документа
	/// - Returns: View отображающего список файлов и папок
	func assembly(
		screenTitle: String,
		folders: [Folder],
		openDocumentResultClosure: OpenDocumentResultClosure?
	) -> OpenDocumentViewController {
		let viewController = OpenDocumentViewController(screenTitle: screenTitle)
		let presenter = OpenDocumentPresenter(
			viewController: viewController
		)
		let worker = OpenDocumentWorker(folders: folders)
		let interactor = OpenDocumentInteractor(
			presenter: presenter,
			worker: worker,
			openDocumentResultClosure: openDocumentResultClosure
		)
		viewController.interactor = interactor

		return viewController
	}
}
