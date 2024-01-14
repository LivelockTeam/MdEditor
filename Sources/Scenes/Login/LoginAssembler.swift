//
//  LoginAssembler.swift
//  TodoList
//
//  Created by Kirill Leonov on 04.12.2023.
//

import UIKit

/// Сборщик сцены Login
final class LoginAssembler {

	/// Метод сборки сцены Login
	func assembly(loginResultClosure: LoginResultClosure?) -> LoginViewController {
		let viewController = LoginViewController()
		let presenter = LoginPresenter(loginResultClosure: loginResultClosure)
		let worker = LoginWorker()
		let interactor = LoginInteractor(presenter: presenter, worker: worker)
		viewController.interactor = interactor

		return viewController
	}
}
