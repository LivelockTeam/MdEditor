//
//  HomeAssembler.swift
//  MdEditor
//
//  Created by Иван Лясковец on 04.02.2024.
//  Copyright © 2024 LivelockTeam. All rights reserved.
//

import Foundation

final class HomeAssembler {
	/// Сборка главного модуля MdEditor'a
	/// - Returns: вью
	static func assembly() -> HomeViewController {
		let viewController = HomeViewController()
		let presenter = HomePresenter(viewController: viewController)
		let interactor = HomeInteractor(presenter: presenter)
		viewController.interactor = interactor
		return viewController
	}
}
