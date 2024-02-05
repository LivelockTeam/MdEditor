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
	}

	struct Response {
	}

	struct ViewModel {
		let items: [Item]

		struct Item {
			let type: ItemType
			let title: String
			let subTitle: String
		}

		enum ItemType: String {
			case folder = "folder.fill"
			case file = "doc.text"
		}
	}
}
