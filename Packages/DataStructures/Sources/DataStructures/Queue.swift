//
//  Queue.swift
//

import Foundation

struct Queue<T> {

	private var elements = DoubleLinkedList<T>()

	/// Возвращает логическое значение, указывающее, пустая ли очередь
	var isEmpty: Bool {
		elements.isEmpty
	}

	/// Возвращает количество элементов в очереди
	var count: Int {
		elements.count
	}

	/// Возвращает первый элемент в очереди
	var peek: T? {
		elements.value(at: 0)
	}

	/// Добавляет элемент в конец очереди
	/// - Parameter element: Элемент для добавления
	mutating func enqueue(_ element: T) {
		elements.append(element)
	}

	/// Удаляет и возвращает первый элемент очереди
	/// - Returns: первый элемент в очереди
	mutating func dequeue() -> T? {
		elements.pop()
	}
}
