//
//  LoginCoordinator.swift
//  TodoList
//
//  Created by Sergey Rumyantsev on 06.12.2023.
//

import UIKit

// MARK: - ILoginCoordinator

/// Протокол координатора потока Login
protocol ILoginCoordinator: ICoordinator, IShowError {

	/// Ззапуск сцены Login
	func showLoginScene()
}

// MARK: - LoginCoordinator

/// Координатор потока Login
final class LoginCoordinator: ILoginCoordinator {

	// MARK: - Public properties

	/// Дочерние координаторы
	var childCoordinator: [ICoordinator] = []

	/// Делегат, уведомляемый о завершении работы
	weak var finishDelegate: ICoordinatorFinishDelegate?

	// MARK: - Dependencies

	/// Контроллер обеспечения навигации
	var navigationController: UINavigationController

	// MARK: - Initialization

	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}

	// MARK: - Public methods

	/// Начало работы координатора
	func start() {
		showLoginScene()
	}

	/// Запуск сцены Login
	func showLoginScene() {
		let viewController = LoginAssembler().assembly(loginResultClosure: handleLoginResult)
		navigationController.setViewControllers([viewController], animated: true)
	}

	// MARK: - Private methods

	private func handleLoginResult(_ result: Result<Void, LoginError>) {
		switch result {
		case .success:
			finish()
		case.failure(let error):
			showError(message: error.localizedDescription)
		}
	}
}
