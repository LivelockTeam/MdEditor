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
		let sorces = [
			("Documents", Bundle.main.resourcePath!) // swiftlint:disable:this force_unwrapping
//			("", FileManager.default.currentDirectoryPath)
		]
		let folders = getFoldersFrom(sorces: sorces)

		let viewController = showOpenDocumentScreen(screenTitle: screenTitle, folders: folders)
		self.navigationController.setViewControllers([viewController], animated: true)
	}

	private func showOpenDocumentScreen(screenTitle: String, folders: [Folder]) -> OpenDocumentViewController {
		let viewController = OpenDocumentAssembler().assembly(
			screenTitle: screenTitle,
			folders: folders
		) { [weak self] item in
			if let folder = item as? Folder {
				guard let viewController = self?.showOpenDocumentScreen(
					screenTitle: folder.name,
					folders: [folder]
				) else { return }
				self?.navigationController.pushViewController(viewController, animated: true)
			} else {
				self?.finishFlow?(URL(fileURLWithPath: item.path))
			}
		}

		return viewController
	}

	private func getFoldersFrom(sorces: [(String, String)]) -> [Folder] {
		var folders: [Folder] = []

		for sorce in sorces {
			if let folder = Folder.getFolder(withName: sorce.0, atFolderPath: sorce.1) {
				folders.append(folder)
			}
		}

		return folders
	}
}
