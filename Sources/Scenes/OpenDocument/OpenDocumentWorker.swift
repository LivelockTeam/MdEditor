//
//  OpenDocumentWorker.swift
//  MdEditor
//
//  Created by Sergey Rumyantsev on 01.02.2024.
//  Copyright © 2024 LivelockTeam. All rights reserved.
//

import Foundation

protocol IOpenDocumentWorker {
	func getFoldersAndFiles() -> [File]
}

final class OpenDocumentWorker: IOpenDocumentWorker {

	// MARK: - Private properties

	private var paths: [String]

	// MARK: - Initialization

	internal init(paths: [String]) {
		self.paths = paths
	}

	// MARK: - Public methods

	func getFoldersAndFiles() -> [File] {
		let fileExplorer = FileExplorer()
		return fileExplorer.getItems(paths: paths)
	}
}
