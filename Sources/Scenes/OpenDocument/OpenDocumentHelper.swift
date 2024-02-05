//
//  OpenDocumentHelper.swift
//  MdEditor
//
//  Created by Sergey Rumyantsev on 04.02.2024.
//  Copyright © 2024 LivelockTeam. All rights reserved.
//

import Foundation

class File {

	// MARK: - Public

	var name = ""
	var path = ""
	var ext = ""
	var size: UInt64 = 0
	var isDir = false
	var creationDate = Date()
	var modificationDate = Date()

	// MARK: - Public methods

	func getFormattedAttributes() -> String {
		let formattedSize = getFormattedSize()
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy.MM.dd HH:mm:ss"

		if isDir {
			return "\(dateFormatter.string(from: modificationDate)) | <dir>"
		} else {
			return "\"\(ext)\" – \(dateFormatter.string(from: modificationDate)) | \(formattedSize)"
		}
	}

	// MARK: - Private methods

	private func getFormattedSize(with size: UInt64) -> String {
		var convertedValue = Double(size)
		var multiplyFactor = 0
		let tokens = ["bytes", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"]
		while convertedValue > 1024 {
			convertedValue /= 1024
			multiplyFactor += 1
		}
		return String(format: "%4.2f %@", convertedValue, tokens[multiplyFactor])
	}

	private func getFormattedSize() -> String {
		return getFormattedSize(with: size)
	}
}

class FileExplorer {

	// MARK: - Private properties

	private var files = [File]()

	// MARK: - Public methods

	func getItems(paths: [String]) -> [File] {
		scan(paths: paths)
		return files
	}

	// MARK: - Private methods

	private func scan(paths: [String]) {
		let fileManager = FileManager.default
		files.removeAll()

		var onlyFolders = [File]()
		var onlyFiles = [File]()

		for path in paths {
			do {
				let items = try fileManager.contentsOfDirectory(atPath: path)
				for item in items {
					if let file = getFile(withNAme: item, atPath: path) {
						if file.isDir {
							onlyFolders.append(file)
						} else {
							onlyFiles.append(file)
						}
					}
				}
			} catch {
				// failed to read directory
			}
		}

		files.append(contentsOf: onlyFolders)
		files.append(contentsOf: onlyFiles)
	}

	private func getFile(withNAme name: String, atPath: String) -> File? {
		let fileManager = FileManager.default

		do {
			let attr = try fileManager.attributesOfItem(atPath: atPath + "/" + name)

			let file = File()
			file.name = name
			file.path = atPath
			if let type = attr[FileAttributeKey.type] as? FileAttributeType {
				file.isDir = type == FileAttributeType.typeDirectory
			}
			if let size = attr[FileAttributeKey.size] as? UInt64 {
				file.size = size
			}
			if let creationDate = attr[FileAttributeKey.creationDate] as? Date {
				file.creationDate = creationDate
			}
			if let modificationDate = attr[FileAttributeKey.modificationDate] as? Date {
				file.modificationDate = modificationDate
			}

			if file.isDir {
				file.ext = ""
			} else {
				file.ext = String(describing: name.split(separator: ".").last!) // swiftlint:disable:this force_unwrapping
			}

			return file
		} catch {
			// failed to read at path
		}

		return nil
	}
}
