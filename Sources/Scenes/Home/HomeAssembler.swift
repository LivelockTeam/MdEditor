//
//  HomeAssembler.swift
//  MdEditor
//
//  Created by Иван Лясковец on 04.02.2024.
//  Copyright © 2024 LivelockTeam. All rights reserved.
//

import Foundation

enum HomeAssembler {
	/// Сборка главного экрана MdEditor'a
	/// - Returns: вью
	static func assembly(menuPointSelectedClosure: ((IndexPath) -> Void)?) -> HomeViewController {
		let viewController = HomeViewController()
		let presenter = HomePresenter(viewController: viewController)
		let interactor = HomeInteractor(presenter: presenter, menuPointSelectedClosure: menuPointSelectedClosure)
		viewController.interactor = interactor
		return viewController
	}
}
