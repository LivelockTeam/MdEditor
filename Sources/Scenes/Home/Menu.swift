//
//  Menu.swift
//  MdEditor
//
//  Created by Иван Лясковец on 05.02.2024.
//  Copyright © 2024 LivelockTeam. All rights reserved.
//

import Foundation

/// Меню главного экрана MdEditor'a
enum Menu {
	case new
	case open
	case about

	var title: String {
		switch self {
		case .new:
			return L10n.Home.newDocument
		case .open:
			return L10n.Home.openDocument
		case .about:
			return L10n.Home.about
		}
	}

	var image: String {
		switch self {
		case .new:
			return "doc"
		case .open:
			return "folder"
		case .about:
			return "info.circle"
		}
	}
}

/// Моковая модель документа
struct MockDocument: IDocument {
	var title: String
}

/// Тестовый протокол для документов
protocol IDocument {
	var title: String { get }
}
