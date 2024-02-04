//
//  HomeInteractor.swift
//  MdEditor
//
//  Created by Иван Лясковец on 04.02.2024.
//  Copyright © 2024 LivelockTeam. All rights reserved.
//

import Foundation

protocol IHomeInteractor {
	/// Событие на предоставление информации для меню.
	func fetchData()

	/// Событие, что пункт был выбран.
	/// - Parameter request: Запрос, содержащий информацию о выбранном пункте меню.
	func didMenuPointSelected(request: HomeModel.Request.MenuPointSelected)
}

final class HomeInteractor: IHomeInteractor {

	// MARK: - Dependencies

	private var presenter: IHomePresenter?

	// TODO: Подключить файловый менеджер для загрузки данных коллекции

	// MARK: - Init

	init(presenter: IHomePresenter) {
		self.presenter = presenter
	}

	// MARK: - Public methods

	func fetchData() {
		//let response = MainModel.Response(data: responseData)
		// presenter.present(response: response)
	}

	func didMenuPointSelected(request: HomeModel.Request.MenuPointSelected) {

	}
}
