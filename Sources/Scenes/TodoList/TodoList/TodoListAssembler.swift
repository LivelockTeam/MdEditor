//
//  TodoListAssembler.swift
//  TodoList
//
//  Created by Kirill Leonov on 04.12.2023.
//

import UIKit
import TaskManagerPackage

/// Сборщик сцены TodoList
final class TodoListAssembler {

	// MARK: - Dependencies

	private let taskManager: ITaskManager

	// MARK: - Initialization

	init(taskManager: ITaskManager) {
		self.taskManager = taskManager
	}

	// MARK: - Public methods

	/// Метод сборки сцены TodoList
	func assembly() -> TodoListViewController {
		let viewController = TodoListViewController()
		let sectionForTaskManagerAdapter = SectionForTaskManagerAdapter(taskManager: taskManager)
		let presenter = TodoListPresenter(viewController: viewController)
		let interactor = TodoListInteractor(
			presenter: presenter,
			sectionManager: sectionForTaskManagerAdapter
		)
		viewController.interactor = interactor

		return viewController
	}
}
