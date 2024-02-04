//
//  MdEditorCoordinator.swift
//  MdEditor
//
//  Created by Илья Горяев on 04.02.2024.
//  Copyright © 2024 LivelockTeam. All rights reserved.
//

import UIKit

final class MdEditorCoordinator: ICoordinator {

	// MARK: - Dependencies

	private let navigationController: UINavigationController

	// MARK: - Init

	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}

	// MARK: - Internal methods

	func start() {
		showEditorStartScreen()
	}

	private func showEditorStartScreen() {
		let viewController = EditorStartScreenAssembler.assembly()
		self.navigationController.setViewControllers([viewController], animated: true)
	}
}
