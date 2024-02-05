//
//  OpenDocumentCoordinator.swift
//  MdEditor
//
//  Created by Sergey Rumyantsev on 02.02.2024.
//  Copyright © 2024 LivelockTeam. All rights reserved.
//

import UIKit

protocol IOpenDocumentCoordinator: ICoordinator {

	/// Метод для завершении сценария
	var finishFlow: ((URL) -> Void)? { get set }
}

final class OpenDocumentCoordinator: IOpenDocumentCoordinator {

	// MARK: - Dependencies

	private let navigationController: UINavigationController

	// MARK: - Internal properties

	var finishFlow: ((URL) -> Void)?

	// MARK: - Initialization

	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}

	// MARK: - Internal methods

	func start() {
		showOpenDocumentScene()
	}

	func showOpenDocumentScene() {
		let screenTitle = "Open document"
		let urls = [URL]()
		let viewController = showOpenDocumentScreen(screenTitle: screenTitle, urls: urls)
		self.navigationController.pushViewController(viewController, animated: true)
	}

	private func showOpenDocumentScreen(screenTitle: String, urls: [URL]) -> OpenDocumentViewController {
		let viewController = OpenDocumentAssembler().assembly(
			screenTitle: screenTitle,
			urls: urls
		) { [weak self] itemType in
			switch itemType {
			case .file(let file):
				self?.finishFlow?(URL(fileURLWithPath: file.path))
			case .folder(let folder):
				guard let url = URL(string: folder.path) else { return }
				guard let viewController = self?.showOpenDocumentScreen(screenTitle: folder.title, urls: [url]) else { return }
				self?.navigationController.pushViewController(viewController, animated: true)
			}
		}

		return viewController
	}
}
