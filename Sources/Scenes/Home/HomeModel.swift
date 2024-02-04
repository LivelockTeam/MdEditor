//
//  HomeModel.swift
//  MdEditor
//
//  Created by Иван Лясковец on 04.02.2024.
//  Copyright © 2024 LivelockTeam. All rights reserved.
//

import Foundation

enum HomeModel {
	enum Request {
		struct MenuPointSelected {
			let indexPath: IndexPath
		}

		struct DocumentSelected {
			let indexPath: IndexPath
		}
	}

	struct Response {
	}

	struct ViewModel {
		/// Содержит в себе список поинтов меню для отображения
		let menuPoints: [MenuPoint]

		/// Содержит в себе список недавних документов для отображения
		let documents: [MdDocument]

		/// Пункт меню
		struct MenuPoint {
			let title: String
			let image: String
		}

		/// Документ
		struct MdDocument {
			let title: String
			// let backgroundColor: UIColor
		}
	}
}
