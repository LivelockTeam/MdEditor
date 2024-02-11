//
//  FolderExplorer.swift
//  MdEditor
//
//  Created by Sergey Rumyantsev on 10.02.2024.
//  Copyright © 2024 LivelockTeam. All rights reserved.
//

import Foundation

protocol IFolderExplorer {
	func getOrderedFoldersAndFiles() -> (folders: [Folder], files: [File])
}

final class FolderExplorer {

	// MARK: - Dependencies

	private let folders: [Folder]

	// MARK: - Initialization

	init(folders: [Folder]) {
		self.folders = folders
	}

	// MARK: - Public methods

	func getOrderedFoldersAndFiles() -> (folders: [Folder], files: [File]) {
		var orderedResult: (folders: [Folder], files: [File]) = ([], [])
		var resultFolders: [Folder] = []
		var resultFiles: [File] = []

		for folder in folders {
			let result = scan(folderPath: folder.path)
			resultFolders += result.folders
			resultFiles += result.files
		}

		resultFolders.sort { $0.name < $1.name }
		resultFiles.sort { $0.name < $1.name }

		orderedResult.folders += resultFolders
		orderedResult.files += resultFiles

		return orderedResult
	}

	// MARK: - Private methods

	private func scan(folderPath: String) -> (folders: [Folder], files: [File]) {
		let fileManager = FileManager.default
		var result: (folders: [Folder], files: [File]) = ([], [])

		do {
			let items = try fileManager.contentsOfDirectory(atPath: folderPath)
			for item in items {
				if let file = File.getFile(withName: item, atFolderPath: folderPath) {
					result.files.append(file)
				}
				if let folder = Folder.getFolder(withName: item, atFolderPath: folderPath) {
					result.folders.append(folder)
				}
			}
		} catch let error as NSError {
			print(error.localizedDescription)
		}

		return result
	}
}
