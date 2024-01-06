//
//  File.swift
//  
//
//  Created by Sergey Rumyantsev on 03.01.2024.
//

import Foundation

// MARK: - Queue - Реализация очереди с использованием двусвязного списка

struct Queue<T> {

	private var elements = DoubleLinkedList<T>()

	/// Возвращает логическое значение, указывающее, пуста ли очередь.
	var isEmpty: Bool {
		elements.isEmpty
	}

	/// Возвращает количество элементов в очереди.
	var count: Int {
		elements.count
	}

	/// Добавляет элемент в конец очереди.
	///
	/// Сложность O(1).
	/// - Parameter element: элемент для добавления в очередь.
	mutating func enqueue(_ element: T) {
		elements.append(element)
	}

	/// Удаляет и возвращает первый элемент очереди.
	///
	/// Сложность O(1).
	/// - Returns: первый элемент очереди.
	mutating func dequeue() -> T? {
		elements.pop()
	}

	/// Возвращает первый элемент очереди.
	var peek: T? {
		elements.value(at: 0)
	}
}
