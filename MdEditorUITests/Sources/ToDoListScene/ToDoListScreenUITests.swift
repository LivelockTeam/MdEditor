//
//  ToDoListScreenUITests.swift
//  MdEditorUITests
//
//  Created by Vlad on 29.01.2024.
//  Copyright © 2024 LivelockTeam. All rights reserved.
//

import XCTest
//import TaskManagerPackage

final class ToDoListScreenUITests: XCTestCase {

	// MARK: - Private properties
	private let app = XCUIApplication()
	private enum ValidCredentials: String {
		case login = "Admin"
		case pass = "1"
	}
	
	// При подключении TaskManagerPackage ошибка - "Linker command failed with exit code 1 (use -v to see invocation)"
	//	private let taskManager = TaskManager()
	
	// MARK: - Test setup

	override func setUp() {
		app.launchArguments = ["-AppleLanguages", "(ru)"]
		app.launch()
		let screen = LoginScreenObject(app: app)
		screen
			.isLoginScreen()
			.set(login: ValidCredentials.login.rawValue)
			.set(pass: ValidCredentials.pass.rawValue)
			.login()

		// Проверка перехода на новый экран
		screen
			.isNotLoginScreen()
		
	}

	// MARK: - Test methods
	func test_isTodoList_shouldBeSuccess() {
		// Проверка что открыт ToDoList
		let screen = ToDoListScreenObject(app: app)
		screen
			.isToDoListScreen()
	}
	
	func testSectionHeaders() throws {
		let tableView = app.tables[ToDoListViewIdentifier.toDoListTableView.description]
		
		let sectionTitles = ["Незавершенные", "Завершенные"] // Как получить локализованный текст??
		
		for (index, title) in sectionTitles.enumerated() {
			let sectionHeader = tableView.staticTexts[title]
			XCTAssertTrue(sectionHeader.exists, "Section header \(index) with title \(title) exists")
		}
	}
	
	// TODO: - подключить TaskManagerPackage
//	func testTaskInformationDisplay() throws {
//		let tableView = app.tables[ToDoListViewIdentifier.toDoListTableView.description]
//		
//		
//		let indexPaths = [
////			IndexPath(row: 0, section: 0),
//			IndexPath(row: 0, section: 1),
//		]
//		
//		for indexPath in indexPaths {
//			let cell = tableView.cells.element(boundBy: indexPath.row)
//			XCTAssertTrue(cell.exists, "Cell at indexPath \(indexPath) exists")
//			
//			
////			let taskTitle = taskManager.uncompletedTasks()[indexPath.row].title // Получаем данные из TaskManagerPackage
//			
//			let taskTitleText = cell.staticTexts["taskTitle"]
//			XCTAssertTrue(taskTitleText.exists, "Task title \("taskTitle") exists")
//		}
//	}
	
	// Toggle task
	// TODO: - доделать
//	func testTaskMovesToNextSection() throws {
//		let screen = ToDoListScreenObject(app: app)
//		screen
//			.toggleTaskCompletion(indexPath: IndexPath(row: 1, section: 0))
	  }
}
