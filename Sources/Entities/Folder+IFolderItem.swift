//
//  Folder+IFolderItem.swift
//  MdEditor
//
//  Created by Sergey Rumyantsev on 10.02.2024.
//  Copyright © 2024 LivelockTeam. All rights reserved.
//

import Foundation

protocol IFolderItem {
	var name: String { get }
	var creationDate: Date { get }
	var modificationDate: Date { get }
	var path: String { get }
}

final class Folder: IFolderItem {

	// MARK: - Properties

	private(set) var name: String
	private(set) var creationDate: Date
	private(set) var modificationDate: Date
	private(set) var path: String

	// MARK: - Initialization

	init(
		name: String,
		creationDate: Date,
		modificationDate: Date,
		path: String
	) {
		self.name = name
		self.creationDate = creationDate
		self.modificationDate = modificationDate
		self.path = path
	}

	// MARK: - Static methods

	/// Получить экземпляр класса Folder на основании объекта в папке
	/// - Parameter withName: имя объекта
	/// - Parameter atFolderPath: путь папки, содержащей объект
	/// - Returns: объект с опциональным типом Folder
	static func getFolder(withName name: String, atFolderPath folderPath: String) -> Folder? {
		let fileManager = FileManager.default

		do {
			let attributes = try fileManager.attributesOfItem(atPath: folderPath + "/" + name)

			if attributes[FileAttributeKey.type] as? FileAttributeType == FileAttributeType.typeDirectory {
				guard let creationDate = attributes[FileAttributeKey.creationDate] as? Date else { return nil }
				guard let modificationDate = attributes[FileAttributeKey.modificationDate] as? Date else { return nil }

				let folder = Folder(
					name: name,
					creationDate: creationDate,
					modificationDate: modificationDate,
					path: folderPath + "/" + name
					)

				return folder
			}
		} catch let error as NSError {
			print(error.localizedDescription)
		}

		return nil
	}
}
