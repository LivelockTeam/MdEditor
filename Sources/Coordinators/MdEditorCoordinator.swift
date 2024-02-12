//
//  MdEditorCoordinator.swift
//  MdEditor
//
//  Created by Илья Горяев on 04.02.2024.
//  Copyright © 2024 LivelockTeam. All rights reserved.
//

import UIKit

final class MdEditorCoordinator: BaseCoordinator {

	// MARK: - Dependencies

	private let navigationController: UINavigationController

	// MARK: - Init

	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}

	// MARK: - Internal methods

	override func start() {
		showHomeScreen()
	}
}

// MARK: - Private methods

private extension MdEditorCoordinator {
	func showHomeScreen() {
		
		#warning("Временный плохой код, чтоб заработали кнопки меню")
		let viewController = HomeAssembler.assembly() { [weak self] index in
			if index.row == 1 {
				self?.showOpenDocument()
			}
		}
		self.navigationController.setViewControllers([viewController], animated: true)
	}

	func showNewDocument() {
		#warning("TODO: Переход на окно с новым документов")
	}

	func showOpenDocument() {

		// Запуск OpenDocument Flow
		let coordinator = OpenDocumentCoordinator(navigationController: navigationController)
		addDependency(coordinator)

		coordinator.finishFlow = { [weak self, weak coordinator] sendedUrl in
			if let url = sendedUrl {
				_ = url // URL выбранного файла
				self?.showHomeScreen()
				coordinator.map { self?.removeDependency($0) }
			} else {
				self?.showHomeScreen()
				coordinator.map { self?.removeDependency($0) }
			}
		}

		coordinator.start()
	}

	func showAbout() {
		#warning("TODO: Переход на окно с документом About")
	}
}
