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
		let viewController = HomeAssembler.assembly()
		self.navigationController.setViewControllers([viewController], animated: true)
	}

	func showNewDocument() {
		#warning("TODO: Переход на окно с новым документов")
	}

	func showOpenDocument() {
		#warning("TODO: Переход на окно с открытием документа (по id или другому параметру?)")

		// Запуск OpenDocument Flow
		let coordinator = OpenDocumentCoordinator(navigationController: navigationController)
		addDependency(coordinator)

		coordinator.finishFlow = { [weak self, weak coordinator] url in
			_ = url // url открываемого файла
			self?.showHomeScreen()
			coordinator.map { self?.removeDependency($0) }
		}

		coordinator.start()
	}

	func showAbout() {
		#warning("TODO: Переход на окно с документом About")

	}
}
