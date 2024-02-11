//
//  OpenDocumentModel.swift
//  MdEditor
//
//  Created by Sergey Rumyantsev on 01.02.2024.
//  Copyright © 2024 LivelockTeam. All rights reserved.
//

import Foundation

enum OpenDocumentModel {

	struct Request {
		let index: IndexPath
	}

	struct Response {
		let folders: [Folder]
		let files: [File]
	}

	struct ViewModel {
		let items: [Item]

		struct Item {
			let icon: IconType
			let title: String
			let subTitle: String
		}

		enum IconType: String {
			case folder = "folder"
			case file = "doc.text"
		}
	}
}
