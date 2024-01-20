//
//  MainCoordinator.swift
//  TodoList
//

import UIKit
import TaskManagerPackage

final class MainCoordinator: BaseCoordinator {

	// MARK: - Dependencies

	private let navigationController: UINavigationController
	private let taskManager: ITaskManager

	// MARK: - Initialization

	init(navigationController: UINavigationController, taskManager: ITaskManager) {
		self.navigationController = navigationController
		self.taskManager = taskManager
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
