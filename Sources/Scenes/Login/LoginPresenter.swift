//
//  LoginPresenter.swift
//  TodoList
//
//  Created by Kirill Leonov on 04.12.2023.
//

import Foundation

/// Typealias замыкания, через которое передаётся результат работы VIP цикла сцены Login в Coordinator
typealias LoginResultClosure = (Result<Void, LoginError>) -> Void

/// Протокол Presenter в сцене Login
protocol ILoginPresenter {

	/// Метод обрабатывающий ответ Interractor для Presenter в сцене Login
	/// - Parameter responce: Структура ответа Interractor для Presenter в сцене Login
	func present(responce: LoginModel.Response)
}

/// Презентер сцены Login
final class LoginPresenter: ILoginPresenter {

	// MARK: - Dependencies

	private var loginResultClosure: LoginResultClosure?

	// MARK: - Initialization

	init(loginResultClosure: LoginResultClosure?) {
		self.loginResultClosure = loginResultClosure
	}

	// MARK: - Public methods

	/// Метод обрабатывающий ответ Interractor для Presenter в сцене Login
	/// - Parameter responce: Структура ответа Interractor для Presenter в сцене Login
	func present(responce: LoginModel.Response) {
		loginResultClosure?(responce.result)
	}
}

extension LoginError: LocalizedError {
	var errorDescription: String? {
		switch self {
		case .wrongPassword:
			return "Неверный пароль."
		case .wrongLogin:
			return "Неверный логин."
		case .emptyFields:
			return "Пустые поля логин или пароль."
		case .errorAuth:
			return "Неверный пароль и логин."
		}
	}
}
