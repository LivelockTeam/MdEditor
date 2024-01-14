//
//  LoginInteractor.swift
//  TodoList
//
//  Created by Kirill Leonov on 04.12.2023.
//

import Foundation

/// Протокол Interactor в сцене Login
protocol ILoginInteractor {

	/// Метод реализующий запрос View к Interractor в сцене Login
	/// - Parameter request: Структура запроса View к Interractor в сцене Login
	func login(request: LoginModel.Request)
}

/// Интерактор сцены Login
final class LoginInteractor: ILoginInteractor {

	// MARK: - Dependencies

	private var presenter: ILoginPresenter?
	private var worker: ILoginWorker

	// MARK: - Initialization

	init(presenter: ILoginPresenter, worker: ILoginWorker) {
		self.presenter = presenter
		self.worker = worker
	}

	// MARK: - Public methods

	/// Метод реализующий запрос View к Interractor в сцене Login
	/// - Parameter request: Структура запроса View к Interractor в сцене Login
	func login(request: LoginModel.Request) {
		let result = worker.login(login: request.login, password: request.password)
		let responce = LoginModel.Response(result: result)

		presenter?.present(responce: responce)
	}
}
