//
//  HomeInteractor.swift
//  MdEditor
//
//  Created by Иван Лясковец on 04.02.2024.
//  Copyright © 2024 LivelockTeam. All rights reserved.
//

import Foundation

/// Протокол интерактора главного экрана MdEditor'a.
protocol IHomeInteractor {
	/// Событие на предоставление информации для меню.
	func fetchData()

	/// Событие, что пункт был выбран.
	/// - Parameter request: Запрос, содержащий информацию о выбранном пункте меню.
	func didMenuPointSelected(request: HomeModel.Request.MenuPointSelected)

	/// Событие, что документ был выбран.
	/// - Parameter request: Запрос, содержащий информацию о выбранном документе.
	func didDocumentSelected(request: HomeModel.Request.DocumentSelected)
}

/// Интерактор главного экрана MdEditor'a.
final class HomeInteractor: IHomeInteractor {

	// MARK: - Dependencies

	private var presenter: IHomePresenter?
	#warning("TODO: Подключить файловый менеджер для загрузки данных коллекции")

	// MARK: - Init

	init(presenter: IHomePresenter) {
		self.presenter = presenter
	}

	// MARK: - Public methods

	func fetchData() {
		#warning("TODO: Обработать загрузку данных")
	}

	func didMenuPointSelected(request: HomeModel.Request.MenuPointSelected) {
		#warning("TODO: Обработать нажатие на кнопку меню")
	}

	func didDocumentSelected(request: HomeModel.Request.DocumentSelected) {
		#warning("TODO: Обработать нажатие по документу")
	}
}
