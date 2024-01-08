//
//  TaskManagerSpy.swift
//  
//
//  Created by Иван Лясковец on 08.01.2024.
//

import Foundation
@testable import TaskManagerPackage

class TaskManagerSpy: ITaskManager {
	// MARK: - Public properties

	var getAllTasksWasCalled: Bool = false
	var getAllCompletedTasksCalled: Bool = false
	var getAllUncompletedTasksCalled: Bool = false
	var addTaskCalled: Bool = false
	var addTasksCalled: Bool = false
	var removeTaskCalled: Bool = false

	// MARK: - Private properties

	private var taskManager: TaskManager

	// MARK: - Init

	init(taskManager: TaskManager) {
		self.taskManager = taskManager
	}

	// MARK: - Methods

	func allTasks() -> [TaskManagerPackage.Task] {
		getAllTasksWasCalled = true
		return taskManager.allTasks()
	}
	
	func completedTasks() -> [TaskManagerPackage.Task] {
		getAllCompletedTasksCalled = true
		return taskManager.completedTasks()
	}
	
	func uncompletedTasks() -> [TaskManagerPackage.Task] {
		getAllUncompletedTasksCalled = true
		return taskManager.uncompletedTasks()
	}
	
	func addTask(task: TaskManagerPackage.Task) {
		addTaskCalled = true
		taskManager.addTask(task: task)
	}
	
	func addTasks(tasks: [TaskManagerPackage.Task]) {
		addTasksCalled = true
		taskManager.addTasks(tasks: tasks)
	}
	
	func removeTask(task: TaskManagerPackage.Task) {
		removeTaskCalled = true
		taskManager.removeTask(task: task)
	}
}
