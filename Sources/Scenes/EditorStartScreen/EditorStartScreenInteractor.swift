//
//  EditorStartScreenInteractor.swift
//  MdEditor
//
//  Created by Илья Горяев on 04.02.2024.
//  Copyright © 2024 LivelockTeam. All rights reserved.
//

import Foundation

protocol IEditorStartScreenInteractor {}

final class EditorStartScreenInteractor {

	// MARK: - Dependencies

	private var presenter: IEditorStartScreenPresenter?

	// MARK: - Init

	init(presenter: IEditorStartScreenPresenter?) {
		self.presenter = presenter
	}
}

extension EditorStartScreenInteractor: IEditorStartScreenInteractor {}
