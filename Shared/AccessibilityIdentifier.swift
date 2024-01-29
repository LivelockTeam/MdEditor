//
//  AccessibilityIdentifier.swift
//  MdEditor
//
//  Created by Иван Лясковец on 17.01.2024.
//  Copyright © 2024 LivelockTeam. All rights reserved.
//

import Foundation

enum LoginViewIdentifier: String {
	case textFieldLogin
	case textFieldPass
	case buttonLogin
}

enum ToDoListViewIdentifier {
	case toDoListTableView
	case toDoListTableViewCell(IndexPath)
	
	var description: String {
		switch self {
		case .toDoListTableView:
			return "toDoListTableView"
		case .toDoListTableViewCell(let indexPath):
			return "toDoListtableViewCellSection\(indexPath.section)Id\(indexPath.row)"
		}
	}
}
