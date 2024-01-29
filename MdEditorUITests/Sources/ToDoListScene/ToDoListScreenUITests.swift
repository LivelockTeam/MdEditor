//
//  ToDoListScreenUITests.swift
//  MdEditorUITests
//
//  Created by Vlad on 29.01.2024.
//  Copyright © 2024 LivelockTeam. All rights reserved.
//

import XCTest

final class ToDoListScreenUITests: XCTestCase {

	// MARK: - Private properties
	private let app = XCUIApplication()

	private enum ValidCredentials: String {
		case login = "Admin"
		case pass = "pa$$32!"
	}
	
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
}
