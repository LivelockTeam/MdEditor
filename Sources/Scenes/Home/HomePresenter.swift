//
//  HomePresenter.swift
//  MdEditor
//
//  Created by Иван Лясковец on 04.02.2024.
//  Copyright © 2024 LivelockTeam. All rights reserved.
//

import Foundation

/// Протокол презентера главного экрана MdEditor'a.
protocol IHomePresenter {
	/// Отображение главного экрана.
	/// - Parameter response: Подготовленные к отображению данные.
	func present(responce: HomeModel.Response)
}

/// Презентер главного экрана MdEditor'a.
final class HomePresenter: IHomePresenter {

	// MARK: - Dependencies

	private weak var viewController: IHomeViewController?

	// MARK: - Initialization

	init(viewController: IHomeViewController?) {
		self.viewController = viewController
	}

	// MARK: - Public methods

	/// Отображение главного экрана.
	/// - Parameter response: Подготовленные к отображению данные.
	func present(responce: HomeModel.Response) {
		#warning("TODO: Создать модель респонса и обработать ее")
	}
}
