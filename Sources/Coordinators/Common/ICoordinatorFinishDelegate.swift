//
//  ICoordinatorFinishDelegate.swift
//  TodoList
//
//  Created by Sergey Rumyantsev on 08.12.2023.
//

import UIKit

/// Протокол делегата, получающего уведомление о завершении
/// от дочернего Coordinator через свой метод `didFinish()`
protocol ICoordinatorFinishDelegate: AnyObject {

	/// Метод делегата, вызываемый дочерними координаторами для уведомления о завершении работы
	/// - Parameter coordinator: Завершивший работу координатор
	func didFinish(_ coordinator: ICoordinator)
}
