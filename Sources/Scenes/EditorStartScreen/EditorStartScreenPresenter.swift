//
//  EditorStartScreenPresenter.swift
//  MdEditor
//
//  Created by Илья Горяев on 04.02.2024.
//  Copyright © 2024 LivelockTeam. All rights reserved.
//

import Foundation

protocol IEditorStartScreenPresenter { }

final class EditorStartScreenPresenter {

	// MARK: - Dependencies

	private weak var viewController: IEditorStartScreenViewController?

	// MARK: - Init

	init(viewController: IEditorStartScreenViewController?) {
		self.viewController = viewController
	}
}

extension EditorStartScreenPresenter: IEditorStartScreenPresenter { }
