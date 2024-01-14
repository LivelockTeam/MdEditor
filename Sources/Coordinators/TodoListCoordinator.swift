//
//  TodoListCoordinator.swift
//  TodoList
//

import UIKit
import TaskManagerPackage

final class TodoListCoordinator: ICoordinator {

	// MARK: - Dependencies

	private let navigationController: UINavigationController
	private let taskManager: ITaskManager

	// MARK: - Initialization

	init(navigationController: UINavigationController, taskManager: ITaskManager) {
		self.navigationController = navigationController
		self.taskManager = taskManager
	}

	// MARK: - Internal methods

	func start() {
		showTodoListScene()
	}

	private func showTodoListScene() {
		let repository = TaskRepositoryStub()
		let orderedTaskManager = OrderedTaskManager(taskManager: taskManager)
		orderedTaskManager.addTasks(tasks: repository.getTasks())

		let assembler = TodoListAssembler(taskManager: orderedTaskManager)
		let viewController = assembler.assembly()
		navigationController.setViewControllers([viewController], animated: true)
	}
}
