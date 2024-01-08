//
//  OrderedTaskManagerTests.swift
//
//
//  Created by Иван Лясковец on 08.01.2024.
//

import XCTest
@testable import TaskManagerPackage

final class OrderedTaskManagerTests: XCTestCase {
	// MARK: - Stored properties

	private var sut: ITaskManager!
	private var taskManagerSpy: TaskManagerSpy!

	// MARK: - Override XCTestCase methods

	override func setUp() {
		makeSut()
	}

	override func tearDown() {
		sut = nil
		taskManagerSpy = nil
	}

	// MARK: - Test methods

	func test_allTasks_withoutTasks_taskListShouldBeEmpty() {
		// Act
		let arrayOfAllTasksIsEmpty = sut.allTasks().isEmpty

		// Assert
		XCTAssertTrue(arrayOfAllTasksIsEmpty, "Ошибка: пустой OrderedTaskManager должен возвращать пустой массив с тасками")
		XCTAssertTrue(taskManagerSpy.getAllTasksWasCalled, "Ошибка: OrderedTaskManager не вызвал метод getAllTasks у вложенного в него TaskManager")
	}

	func test_addTask_testTask_taskListShouldNotBeEmpty() {
		// Act
		let task = Task.init(title: "Test", completed: false)
		sut.addTask(task: task)
		let arrayOfAllTasksIsEmpty = sut.allTasks().isEmpty

		// Assert
		XCTAssertTrue(!arrayOfAllTasksIsEmpty, "Ошибка: после добавления таски, массив не должен быть пустым")
		XCTAssertTrue(taskManagerSpy.addTaskCalled, "Ошибка: OrderedTaskManager не вызвал метод addTask у вложенного в него TaskManager")
	}

	func test_completedTasks_withTwoCompletedAndOneUncompletedTasks_taskListShouldContainOneCompletedTask() {
		// Act
		let taskOne = Task.init(title: "Test1", completed: false)
		let taskTwo = Task.init(title: "Test2", completed: true)
		let taskThree = Task.init(title: "Test3", completed: true)
		sut.addTasks(tasks: [taskOne, taskTwo, taskThree])
		let expectedResult = 2

		// Assert
		XCTAssertEqual(sut.completedTasks().count, expectedResult, "Ошибка: Число элементов массива тасок не равно ожидаемому (2м)")
		XCTAssertTrue(taskManagerSpy.getAllCompletedTasksCalled, "Ошибка: OrderedTaskManager не вызвал метод completedTasks у вложенного в него TaskManager")
	}

	func test_completedTasks_withTwoUnCompletedAndOneCompletedTasks_taskListShouldContainOneUnCompletedTask() {
		// Act
		let taskOne = Task.init(title: "Test1", completed: true)
		let taskTwo = Task.init(title: "Test2", completed: false)
		let taskThree = Task.init(title: "Test3", completed: false)
		sut.addTasks(tasks: [taskOne, taskTwo, taskThree])
		let expectedResult = 2

		// Assert
		XCTAssertEqual(sut.uncompletedTasks().count, expectedResult, "Ошибка: Число элементов массива тасок не равно ожидаемому (2м)")
		XCTAssertTrue(taskManagerSpy.getAllUncompletedTasksCalled, "Ошибка: OrderedTaskManager не вызвал метод uncompletedTasks у вложенного в него TaskManager")
	}

	func test_addTasks_arrayOfThreeTestTasks_taskListShouldContainThreeTasks() {
		// Act
		let taskOne = Task.init(title: "Test1", completed: false)
		let taskTwo = Task.init(title: "Test2", completed: false)
		let taskThree = Task.init(title: "Test3", completed: false)
		sut.addTasks(tasks: [taskOne, taskTwo, taskThree])
		let expectedResult = 3

		// Assert
		XCTAssertEqual(sut.allTasks().count, expectedResult, "Ошибка: Число элементов массива тасок не равно ожидаемому (3м)")
		XCTAssertTrue(taskManagerSpy.addTasksCalled, "Ошибка: OrderedTaskManager не вызвал метод addTasks у вложенного в него TaskManager")
	}

	func test_removeTask_testTask_taskListWithoutCurrentTask() {
		// Act
		let task = Task.init(title: "Test", completed: false)
		sut.addTask(task: task)
		sut.removeTask(task: task)
		let taskIndex = sut.allTasks().firstIndex(where: { $0 === task })

		// Assert
		XCTAssertNil(taskIndex, "Ошибка: таска не удалена из массива с таксками")
		XCTAssertTrue(taskManagerSpy.removeTaskCalled, "Ошибка: OrderedTaskManager не вызвал метод removeTask у вложенного в него TaskManager")
	}
}

// MARK: - Private methods

private extension OrderedTaskManagerTests {
	func makeSut() {
		taskManagerSpy = TaskManagerSpy(taskManager: TaskManager())
		sut = OrderedTaskManager(taskManager: taskManagerSpy)
	}
}
