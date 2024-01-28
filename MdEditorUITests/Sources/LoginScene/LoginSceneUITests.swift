//
//  LoginSceneUITests.swift
//  MdEditorUITests
//
//  Created by Sergey Rumyantsev on 21.01.2024.
//  Copyright © 2024 LivelockTeam. All rights reserved.
//

import XCTest

final class LoginSceneUITests: XCTestCase {

	// MARK: - Private properties

	private let app = XCUIApplication()

	private enum ValidCredentials: String {
		case login = "Admin"
		case pass = "pa$$32!"
	}
	private enum NotValidCredentials: String {
		case login = "nimdA"
		case pass = "!23$$ap"
	}

	// MARK: - Test setup

	override func setUp() {
		app.launchArguments = ["-AppleLanguages", "(ru)"]
		app.launch()
	}

	// MARK: - Test methods

	func test_login_withValidCredentials_shouldBeSuccess() {
		let screen = LoginScreenObject(app: app)

		// Авторизация с корректными данными
		screen
			.isLoginScreen()
			.set(login: ValidCredentials.login.rawValue)
			.set(pass: ValidCredentials.pass.rawValue)
			.login()

		// Проверка перехода на новый экран
		screen
			.isNotLoginScreen()
	}

	func test_login_withNotValidCredentials_shouldBeFail() {
		let screen = LoginScreenObject(app: app)

		// Авторизация с некорректными данными
		screen
			.isLoginScreen()
			.set(login: NotValidCredentials.login.rawValue)
			.set(pass: NotValidCredentials.pass.rawValue)
			.login()

		// Обработка уведомления об ошибке
		// UIInterruptionMonitor не отлавливает
		let errorMessage = app.alerts.staticTexts["Неверный пароль и логин."]
		if errorMessage.exists {
			app.alerts.buttons["Ок"].tap()
		} else {
			XCTAssertTrue(errorMessage.exists, "Ожидаемое сообщение об ошибке не обнаружено")
		}

		// Проверка возврата к экрану Login
		screen
			.isLoginScreen()
	}
}
