//
//  IShowError.swift
//  TodoList
//
//  Created by Sergey Rumyantsev on 08.12.2023.
//

import UIKit

/// Протокол отображения ошибок
protocol IShowError {

	/// Метод отображения ошибое
	/// - Parameter message: Описание ошибки
	func showError(message: String)
}

extension IShowError where Self: ICoordinator {

	/// Реализация по умолчанию для метода `showError(message: String)` протокола `IShowError`
	///  доступная для объектов реализующих протокол `ICoordinator`
	/// - Parameter message: Описание ошибки
	func showError(message: String) {
		let alert: UIAlertController
		alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
		let action = UIAlertAction(title: "Ok", style: .default)
		alert.addAction(action)
		navigationController.present(alert, animated: true, completion: nil)
	}
}
