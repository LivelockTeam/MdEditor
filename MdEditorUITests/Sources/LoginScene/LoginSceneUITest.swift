//
//  LoginSceneUITest.swift
//  MdEditorUITests
//
//  Created by Sergey Rumyantsev on 21.01.2024.
//  Copyright © 2024 LivelockTeam. All rights reserved.
//

import XCTest

final class LoginSceneUITest: XCTestCase {

	private let app = XCUIApplication()

	private let validLogin = "Admin"
	private let validPass = "pa$$32!"
	private let notValidLogin = "nimdA"
	private let notValidPass = "!23$$ap"

	override func setUp() {
		app.launchArguments = ["-AppleLanguages", "(ru)"]
		app.launch()
	}

	func test_login_withValidCredentials_shouldBeSuccess() {
		let screen = LoginScreenObject(app: app)

		screen
			.isLoginScreen()
			.set(login: validLogin)
			.set(pass: validPass)
			.login()

		screen
			.isNotLoginScreen()
	}

	func test_login_withNotValidCredentials_shouldBeFail() {
		let screen = LoginScreenObject(app: app)

		screen
			.isLoginScreen()
			.set(login: notValidLogin)
			.set(pass: notValidPass)
			.login()

//		addUIInterruptionMonitor(withDescription: "Error") { (alert) -> Bool in
//			let errorMessage = "Неверный пароль и логин."
//			XCTAssert(alert.staticTexts[errorMessage].exists, "Ожидаемое сообщение об ошибке не обнаружено")
//
//			let okButton = alert.buttons["Ок"]
//			okButton.tap()
//			return true
//		}

		let errorMessage = app.alerts.staticTexts["Неверный пароль и логин."]
		if errorMessage.exists {
			app.alerts.buttons["Ок"].tap()
		} else {
			XCTAssertTrue(errorMessage.exists, "Ожидаемое сообщение об ошибке не обнаружено")
		}

		screen
			.isLoginScreen()
	}
}
