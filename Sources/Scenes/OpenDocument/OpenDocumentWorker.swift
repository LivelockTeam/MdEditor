//
//  OpenDocumentWorker.swift
//  MdEditor
//
//  Created by Sergey Rumyantsev on 01.02.2024.
//  Copyright © 2024 LivelockTeam. All rights reserved.
//

import Foundation

protocol IOpenDocumentWorker {
	func getFoldersAndFiles() -> (folders: [Folder], files: [File])
	func getItem(byIndex index: IndexPath) -> IFolderItem
}

final class OpenDocumentWorker: IOpenDocumentWorker {

	// MARK: - Dependencies

	private var folderExplorer: FolderExplorer {
		FolderExplorer(folders: folders)
	}

	// MARK: - Private properties

	private var folders: [Folder]

	// MARK: - Initialization

	init(folders: [Folder]) {
		self.folders = folders
	}

	// MARK: - Public methods

	func getFoldersAndFiles() -> (folders: [Folder], files: [File]) {
		folderExplorer.getOrderedFoldersAndFiles()
	}

	func getItem(byIndex index: IndexPath) -> IFolderItem {
		var allItems: [IFolderItem] = []
		let foldersAndFiles = getFoldersAndFiles()

		allItems += foldersAndFiles.folders
		allItems += foldersAndFiles.files

		return allItems[index.row]
	}
}
