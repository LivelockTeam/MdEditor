//
//  ToDoListScreenObject.swift
//  MdEditor
//
//  Created by Илья Горяев on 21.01.2024.
//  Copyright © 2024 LivelockTeam. All rights reserved.
//

import XCTest

final class ToDoListScreenObject: BaseScreenObject {
	
	// MARK: - Private properties
	private lazy var toDoListTableView = app.tables[ToDoListViewIdentifier.toDoListTableView.description]
	
	// MARK: - ScreenObject methods
	
	@discardableResult
	func isToDoListScreen() -> Self {
		assert(toDoListTableView, [.exists])
		return self
	}
	
	@discardableResult
	func toggleTaskCompletion(indexPath: IndexPath) -> Self {
		let rowByIndexPath = getToDoListTableViewSection(indexPath: indexPath)
		assert(rowByIndexPath, [.exists])
		rowByIndexPath.tap()
		return self
	}
	
}

private extension ToDoListScreenObject {
	func getToDoListTableViewSection(indexPath: IndexPath) -> XCUIElement {
		app.tableRows[ToDoListViewIdentifier.toDoListTableViewCell(indexPath).description]
	}
}
