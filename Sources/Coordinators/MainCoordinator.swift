//
//  MainCoordinator.swift
//  TodoList
//
//  Created by Sergey Rumyantsev on 06.12.2023.
//

import UIKit
import TaskManagerPackage

// MARK: - IMainCoordinator

/// Протокол главного Coordinator приложения
protocol IMainCoordinator: ICoordinator, ICoordinatorFinishDelegate {

	/// Запуск потока Login
	func runLoginFlow()

	/// Запуск потока TodoList
	func runTodoListFlow()
}

// MARK: - MainCoordinator

final class MainCoordinator: IMainCoordinator {

	// MARK: - Public properties

	/// Дочерние координаторы
	var childCoordinator: [ICoordinator] = []

	/// Делегат, уведомляемый о завершении работы
	var finishDelegate: ICoordinatorFinishDelegate?

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
		runLoginFlow()
	}

	/// Запуск потока Login
	func runLoginFlow() {
		let coordinator = LoginCoordinator(navigationController: navigationController)
		coordinator.finishDelegate = self
		childCoordinator.append(coordinator)
		coordinator.start()
	}

	/// Запуск потока TodoList
	func runTodoListFlow() {
		let coordinator = TodoListCoordinator(
			navigationController: navigationController,
			taskManager: taskManager
		)
		childCoordinator.append(coordinator)
		coordinator.start()
	}

	// MARK: - ICoordinatorFinishDelegate

	/// Метод, вызываемый дочерними координаторами для уведомления о завершении работы
	func didFinish(_ coordinator: ICoordinator) {
		if coordinator is ILoginCoordinator {
			childCoordinator.removeAll { $0 === coordinator }
			runTodoListFlow()
		}
	}
}
