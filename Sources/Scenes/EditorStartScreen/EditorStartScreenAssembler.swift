//
//  EditorStartScreenAssembler.swift
//  MdEditor
//
//  Created by Илья Горяев on 04.02.2024.
//  Copyright © 2024 LivelockTeam. All rights reserved.
//

import Foundation

final class EditorStartScreenAssembler {

	static func assembly() -> EditorStartScreenViewController {
		let viewController = EditorStartScreenViewController()
		let presenter = EditorStartScreenPresenter(viewController: viewController)
		let interactor = EditorStartScreenInteractor(presenter: presenter)
		viewController.interactor = interactor
		return viewController
	}
}
