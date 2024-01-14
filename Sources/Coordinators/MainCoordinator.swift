//
//  MainCoordinator.swift
//  TodoList
//

import UIKit
import TaskManagerPackage

final class MainCoordinator: BaseCoordinator {

	// MARK: - Dependencies

	var navigationController: UINavigationController
	private let taskManager = TaskManager()

	// MARK: - Initialization

	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}

	// MARK: - Internal methods

	override func start() {
		let coordinator = TodoListCoordinator(
			navigationController: navigationController,
			taskManager: taskManager
		)
		addDependency(coordinator)
		coordinator.start()
	}
}
