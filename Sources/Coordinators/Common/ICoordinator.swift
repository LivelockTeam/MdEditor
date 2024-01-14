//
//  ICoordinator.swift
//  TodoList
//
//  Created by Sergey Rumyantsev on 07.12.2023.
//

import UIKit

/// Протокол абстрактного координатора
protocol ICoordinator: AnyObject {

	/// Контроллер обеспечения навигации
	var navigationController: UINavigationController { get set }

	/// Дочерние координаторы
	var childCoordinator: [ICoordinator] { get set }

	/// Делегат, уведомляемый о завершении работы
	var finishDelegate: ICoordinatorFinishDelegate? { get set }

	/// Начало работы координатора
	func start()

	/// Завершение работы координатора
	func finish()
}

extension ICoordinator {

	/// Реализация по умолчанию для метода `finish()` протокола `ICoordinator`
	///  с уведомлением делегата о завершении работы текущего координатора
	func finish() {
		childCoordinator.removeAll()
		finishDelegate?.didFinish(self)
	}
}
