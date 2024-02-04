//
//  HomeModel.swift
//  MdEditor
//
//  Created by Иван Лясковец on 04.02.2024.
//  Copyright © 2024 LivelockTeam. All rights reserved.
//

import UIKit

enum HomeModel {
	enum Request {
		struct MenuPointSelected {
			let indexPath: IndexPath
		}
	}

	struct Response {
		var result: Result<Void, Error>
	}

	struct ViewModel {
		/// Содержит в себе список поинтов меню для отображения
		let menuPoints: [MenuPoint]

		/// Пункт меню
		struct MenuPoint {
			let title: String
			let image: UIImage?
		}
	}
}
