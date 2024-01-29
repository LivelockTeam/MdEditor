//
//  LoginScreenObject.swift
//  MdEditorUITests
//
//  Created by Иван Лясковец on 20.01.2024.
//  Copyright © 2024 LivelockTeam. All rights reserved.
//

import XCTest

final class LoginScreenObject: BaseScreenObject {

	// MARK: - Private properties

	private lazy var textFieldLogin = app.textFields[LoginViewIdentifier.textFieldLogin.rawValue]
	private lazy var textFieldPass = app.secureTextFields[LoginViewIdentifier.textFieldPass.rawValue]
	private lazy var buttonLogin = app.buttons[LoginViewIdentifier.buttonLogin.rawValue]

	// MARK: - ScreenObject methods

	@discardableResult
	func isLoginScreen() -> Self {
		assert(textFieldLogin, [.exists])
		assert(textFieldPass, [.exists])
		assert(buttonLogin, [.exists])
		return self
	}

	@discardableResult
	func isNotLoginScreen() -> Self {
		assert(textFieldLogin, [.doesNotExist])
		assert(textFieldPass, [.doesNotExist])
		assert(buttonLogin, [.doesNotExist])
		return self
	}

	@discardableResult
	func set(login: String) -> Self {
		assert(textFieldLogin, [.exists])
		textFieldLogin.tap()
		textFieldLogin.typeText(login)
		return self
	}

	@discardableResult
	func set(pass: String) -> Self {
		assert(textFieldPass, [.exists])
		textFieldPass.tap()
		textFieldPass.typeText(pass)
		return self
	}

	@discardableResult
	func login() -> Self {
		assert(buttonLogin, [.exists])
		buttonLogin.tap()
		return self
	}
}
