//
//  EditorStartScreenViewController.swift
//  MdEditor
//
//  Created by Илья Горяев on 04.02.2024.
//  Copyright © 2024 LivelockTeam. All rights reserved.
//

import UIKit

protocol IEditorStartScreenViewController: AnyObject {}

final class EditorStartScreenViewController: UIViewController {

	// MARK: - Dependencies

	var interactor: IEditorStartScreenInteractor?

	// MARK: - Init

	init() {
		super.init(nibName: nil, bundle: nil)
		configureUI()
		self.view.backgroundColor = .red
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

private extension EditorStartScreenViewController {

	func configureUI() {
		self.title = L10n.MdEditor.title
		navigationController?.navigationBar.prefersLargeTitles = true
	}
}

extension EditorStartScreenViewController: IEditorStartScreenViewController {}
