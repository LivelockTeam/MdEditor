//
//  AppCoordinator.swift
//  TodoList
//

import UIKit
import TaskManagerPackage

final class AppCoordinator: BaseCoordinator {

	// MARK: - Dependencies

	private var window: UIWindow?
	private let navigationController: UINavigationController
	private let taskManager: ITaskManager

	// MARK: - Initialization

	init(window: UIWindow?, taskManager: ITaskManager) {
		self.window = window
		self.navigationController = UINavigationController()
		self.taskManager = taskManager
	}

	// MARK: - Internal methods

	override func start() {
		runMdEditorFlow()
	}

	func runLoginFlow() {
		let coordinator = LoginCoordinator(navigationController: navigationController)
		addDependency(coordinator)

		coordinator.finishFlow = { [weak self, weak coordinator] in
			self?.runMainFlow()
			coordinator.map { self?.removeDependency($0) }
		}

		coordinator.start()

		window?.rootViewController = navigationController
		window?.makeKeyAndVisible()
	}

	func runMainFlow() {
		let coordinator = MainCoordinator(navigationController: navigationController, taskManager: taskManager)
		addDependency(coordinator)
		coordinator.start()
	}

	func runMdEditorFlow() {
		let coordinator = MdEditorCoordinator(navigationController: navigationController)
		addDependency(coordinator)
		coordinator.start()

		window?.rootViewController = navigationController
		window?.makeKeyAndVisible()
	}
}
