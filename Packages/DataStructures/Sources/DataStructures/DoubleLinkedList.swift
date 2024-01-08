//
//  DoubleLinkedList.swift
//

import Foundation

/// Связаный двунаправленный список
struct DoubleLinkedList<T> {

	/// Узел двунаправленного списка
	class Node<T> {

		/// Значение, которое хранит узел
		var value: T

		/// Предыдущий узел
		var previous: Node<T>?

		/// Следующий узел
		var next: Node<T>?

		/// Инициализатор узла двунаправленного связного списка
		/// - Parameters:
		/// - value: Значение, которое хранится в узле
		/// - previous: Предыдущий узел
		/// - next: Следующий узел
		init(_ value: T, previous: Node<T>? = nil, next: Node<T>? = nil) {
			self.value = value
			self.next = next
			self.previous = previous
		}
	}

	/// Начальный элемент двусвязного списка
	private var head: Node<T>?

	/// Последний элемент двусвязного списка
	private var tail: Node<T>?

	/// Возвращает количество элементов двусвязного списка
	private(set) var count: Int = 0

	/// Возвращает логическое значение, определяющее пустой список или нет
	var isEmpty: Bool {
		head == nil && tail == nil
	}

	/// Инициализатор списка
	/// - Parameter value: Значение, которое будет вставлено в начало списка
	init(value: T? = nil) {
		if let value = value {
			let newNode = Node(value)
			head = newNode
			tail = newNode
			count = 1
		}
	}

	/// Добавление элемента в начало списка
	/// - Parameter value: Значение, которое будет хранится в узле, который добавляется
	mutating func push(_ value: T) {
		let newNode = Node(value, next: head)
		head?.previous = newNode
		head = newNode

		if tail == nil { tail = head }

		count += 1
	}

	/// Добавление элемента в конец списка
	/// - Parameter value: Значение, которое будет хранится в узле, который добавляется
	mutating func append(_ value: T) {
		let newNode = Node(value, previous: tail)
		tail?.next = newNode
		tail = newNode

		if head == nil { head = tail }

		count += 1
	}

	/// Вставка в середину двунапрвленного списка
	/// - Parameters:
	/// - value: Значение в узле, который вставляем
	/// - index: Индекс, после которого будет вставлен узел
	mutating func insert(_ value: T, after index: Int) {
		guard let currentNode = node(at: index) else { return }
		let nextNode = currentNode.next
		let newNode = Node(value, previous: currentNode, next: nextNode)
		currentNode.next = newNode
		nextNode?.previous = newNode

		if newNode.next == nil { tail = newNode }
		count += 1
	}

	/// Извлечение из начала списка
	///
	/// - Returns: Извлеченное из списка значение
	mutating func pop() -> T? {
		guard let currentHead = head else { return nil }
		head = currentHead.next
		head?.previous = nil
		if isEmpty { tail = nil }
		count -= 1
		return currentHead.value
	}

	/// Извлечение из конца списка
	///
	/// - Returns: Извлеченное из списка значение
	mutating func removeLast() -> T? {
		guard let currentTail = tail else { return nil }
		tail = currentTail.previous
		tail?.next = nil
		if isEmpty { head = nil }
		count -= 1
		return currentTail.value
	}

	/// Извлечение из середины списка
	/// - Parameter index: Индекс, после которого надо извлеч значение.
	/// - Returns: Извлеченное из списка значение.
	mutating func remove(after index: Int) -> T? {
		guard let currentNode = node(at: index), let nextNode = currentNode.next else { return nil }
		if nextNode === tail {
			tail = currentNode
			currentNode.next = nil
		} else {
			currentNode.next = nextNode.next
			nextNode.next?.previous = currentNode
		}
		count -= 1
		return nextNode.value
	}

	/// Возвращает значение по индексу
	/// - Parameter index: Индекс, значение по которому хотим получить
	/// - Returns: Значение в данном узле
	func value(at index: Int) -> T? {
		node(at: index)?.value
	}
}

private extension DoubleLinkedList {

	/// Возвращает узел по указанному индексу
	///
	/// - Parameter index: Индекс, по которому нужно вернуть узел
	/// - Returns: Возвращаемый узел списка
	func node(at index: Int) -> Node<T>? {
		guard index >= 0 && index < count else { return nil }
		var currentIndex = 0
		var currentNode: Node<T>?
		if index <= count / 2 {
			currentNode = head
			while currentIndex < index {
				currentNode = currentNode?.next
				currentIndex += 1
			}
		} else {
			currentIndex = count - 1
			currentNode = tail
			while currentIndex > index {
				currentNode = currentNode?.previous
				currentIndex -= 1
			}
		}
		return currentNode
	}
}

extension DoubleLinkedList.Node: CustomStringConvertible {
	var description: String {
		"\(value)"
	}
}

extension DoubleLinkedList: CustomStringConvertible {
	var description: String {
		var values = [String]()
		var current = head

		while current != nil {
			values.append("\(current!)")
			current = current?.next
		}

		return "count = \(count), list = " + values.joined(separator: " <-> ")
	}
}
