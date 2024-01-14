//
//  TodoListCoordinator.swift
//  TodoList
//
//  Created by Sergey Rumyantsev on 06.12.2023.
//

import UIKit
import TaskManagerPackage

// MARK: - ITodoListCoordinator

/// Протокол координатора потока TodoList
protocol ITodoListCoordinator: ICoordinator {

	/// Запуск сцены TodoList
	func showTodoListScene()
}

// MARK: - TodoListCoordinator

/// Координатор потока TodoList
final class TodoListCoordinator: ITodoListCoordinator {

	// MARK: - Public properties

	/// Дочерние координаторы
	var childCoordinator: [ICoordinator] = []

	/// Делегат, уведомляемый о завершении работы
	weak var finishDelegate: ICoordinatorFinishDelegate?

	// MARK: - Dependencies

	/// Контроллер обеспечения навигации
	var navigationController: UINavigationController

	/// Менеджер задач
	private let taskManager: ITaskManager

	// MARK: - Initialization

	init(navigationController: UINavigationController, taskManager: ITaskManager) {
		self.navigationController = navigationController
		self.taskManager = taskManager
	}

	// MARK: - Public methods

	/// Начало работы координатора
	func start() {
		showTodoListScene()
	}

	/// Запуск сцены TodoList
	func showTodoListScene() {
		let viewController = TodoListAssembler(
			taskManager: taskManager
		).assembly()
		navigationController.setViewControllers([viewController], animated: true)
	}
}
