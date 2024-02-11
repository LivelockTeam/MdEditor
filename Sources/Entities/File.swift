//
//  File.swift
//  MdEditor
//
//  Created by Sergey Rumyantsev on 10.02.2024.
//  Copyright © 2024 LivelockTeam. All rights reserved.
//

import Foundation

final class File: IFolderItem {

	// MARK: - Properties

	private(set) var name: String
	private(set) var ext: String
	private(set) var size: Double
	private(set) var creationDate: Date
	private(set) var modificationDate: Date
	private(set) var path: String

	// MARK: - Initialization

	init(
		name: String,
		ext: String,
		size: Double,
		creationDate: Date,
		modificationDate: Date,
		path: String
	) {
		self.name = name
		self.ext = ext
		self.size = size
		self.creationDate = creationDate
		self.modificationDate = modificationDate
		self.path = path
	}

	// MARK: - Static methods

	static func getFile(withName name: String, atFolderPath folderPath: String) -> File? {
		let fileManager = FileManager.default

		do {
			let attributes = try fileManager.attributesOfItem(atPath: folderPath + "/" + name)

			if attributes[FileAttributeKey.type] as? FileAttributeType == FileAttributeType.typeRegular {
				guard let size = attributes[FileAttributeKey.size] as? Double else { return nil }
				guard let creationDate = attributes[FileAttributeKey.creationDate] as? Date else { return nil }
				guard let modificationDate = attributes[FileAttributeKey.modificationDate] as? Date else { return nil }

				let file = File(
					name: name,
					ext: String(describing: name.split(separator: ".").last!), // swiftlint:disable:this force_unwrapping
					size: size,
					creationDate: creationDate,
					modificationDate: modificationDate,
					path: folderPath + "/" + name
				)

				return file
			}
		} catch let error as NSError {
			print(error.localizedDescription)
		}

		return nil
	}

	// MARK: - Public methods

	func getFormattedSize() -> String {
		var convertedValue = size
		var multiplyFactor = 0
		let tokens = ["bytes", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"]

		while convertedValue > 1024 {
			convertedValue /= 1024
			multiplyFactor += 1
		}

		return String(format: "%4.2f %@", convertedValue, tokens[multiplyFactor])
	}

	func loadFileBody() -> String {
		var text = ""

		do {
			text = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
		} catch let error as NSError {
			print(error.localizedDescription)
		}

		return text
	}
}
