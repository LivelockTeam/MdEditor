//
//  HomePresenter.swift
//  MdEditor
//
//  Created by Иван Лясковец on 04.02.2024.
//  Copyright © 2024 LivelockTeam. All rights reserved.
//

import Foundation

protocol IHomePresenter {
	/// Отображение главного экрана.
	/// - Parameter response: Подготовленные к отображению данные.
	func present(responce: HomeModel.Response)
}

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

	}
}
