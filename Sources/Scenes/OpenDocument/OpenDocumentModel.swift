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
		let type: ItemType
		let title: String
		let path: String

		enum ItemType {
			case folder
			case file
		}
	}

	struct Response {
		let items: [File]
	}

	struct ViewModel {
		let items: [Item]

		struct Item {
			let type: ItemType
			let title: String
			let subTitle: String
			let path: String
		}

		enum ItemType: String {
			case folder = "folder"
			case file = "doc.text"
		}
	}
}
