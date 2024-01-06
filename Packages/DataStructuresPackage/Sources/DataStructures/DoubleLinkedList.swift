//
//  File.swift
//  
//
//  Created by Sergey Rumyantsev on 03.01.2024.
//

import Foundation

// MARK: - DoubleLinkedList - Реализация двусвязного списка

/// Узел линейного однонаправленного списка.
class Node<T> {

	/// Значение, которое хранит узел.
	var value: T

	/// Ссылка на предыдущий узел, если он есть.
	var previous: Node<T>?

	/// Ссылка на следующий узел, если он есть.
	var next: Node<T>?

	/// Инициализатор узла двусвязного списка.
	/// - Parameters:
	///   - value: Значение для хранения в узле;
	///   - previous: Ссылка на предыдущий узел, если он есть;
	///   - next: Ссылка на следующий узел, если он есть.
	init(_ value: T, previous: Node<T>? = nil, next: Node<T>? = nil) {
		self.value = value
		self.previous = previous
		self.next = next
	}
}

/// Двусвязный список.
struct DoubleLinkedList<T> {
	private var head: Node<T>?
	private var tail: Node<T>?

	/// Возвращает количество элементов списка.
	private(set) var count: Int = 0

	/// Возвращает логическое значение, определяющее пуст ли список.
	///
	/// Сложность O(1).
	var isEmpty: Bool {
		head == nil
	}

	/// Инициализатор списка.
	/// - Parameter value: Значение, которое будет добавлено в список.
	init(value: T? = nil) {
		if let value = value {
			push(value)
		}
	}

	/// Добавление значения в начало списка.
	///
	/// Сложность O(1).
	/// - Parameter value: Значение, которое будет добавлено в список.
	mutating func push(_ value: T) {
		let newNode = Node(value, next: head)
		head?.previous = newNode

		if tail == nil {
			tail = head
		}

		head = newNode
		count += 1
	}

	/// Вставка значения в середину списка.
	///
	/// Сложность O(n).
	/// - Parameters:
	///   - value: Значение, которое будет вставлено в список;
	///   - index: Индекс, после которого будет вставлено значение.
	mutating func insert(_ value: T, after index: Int) {
		guard let node = node(at: index) else { return }
		let newNode = Node(value, previous: node, next: node.next)
		node.next?.previous = newNode
		node.next = newNode
		count += 1
	}

	/// Добавление значения в конец списка.
	///
	/// Сложность O(1).
	/// - Parameter value: Значение, которое будет добавлено в список.
	mutating func append(_ value: T) {
		count += 1
		guard head != nil else {
			head = Node(value)
			return
		}
		guard tail != nil else {
			tail = Node(value, previous: head)
			head?.next = tail
			return
		}

		let node = Node(value, previous: tail)
		tail?.next = node
		tail = node
	}

	/// Поиск значения элемента списка по индексу.
	///
	/// Сложность O(n).
	/// - Returns: Значение элемента из списка.
	func value(at index: Int) -> T? {
		node(at: index)?.value
	}

	/// Извлечение значения из начала списка.
	///
	/// Сложность O(1).
	/// - Returns: Извлеченное из списка значение.
	mutating func pop() -> T? {
		guard head != nil else { return nil }

		defer {
			head?.next?.previous = nil
			head = head?.next
			count -= 1
		}

		return head?.value
	}

	/// Извлечение значения из середины списка.
	///
	/// Сложность O(n).
	/// - Parameter index: Индекс элемента, значение которого надо извлечь.
	/// - Returns: Извлеченное из списка значение.
	mutating func remove(at index: Int) -> T? {
		guard let node = node(at: index) else { return nil }
		guard index != 0 else { return pop() }
		guard index != count - 1 else { return removeLast() }

		node.next?.previous = node.previous
		node.previous?.next = node.next
		count -= 1

		return node.value
	}

	/// Извлечение значения из конца списка.
	///
	/// Сложность O(1).
	/// - Returns: Извлеченное из списка значение.
	mutating func removeLast() -> T? {
		guard let head = head else { return nil }
		guard head.next != nil else { return pop() }

		defer {
			tail?.previous?.next = nil
			tail = count > 2 ? tail?.previous : nil
			count -= 1
		}

		return tail?.value
	}
}

private extension DoubleLinkedList {

	/// Возвращает узел списка по индексу.
	///
	/// Сложность O(n)
	/// - Parameter index: Индекс, по которому нужно вернуть узел списка.
	/// - Returns: Возвращаемый узел списка.
	private func node(at index: Int) -> Node<T>? {
		var currentIndex = 0
		var currentNode = head

		while currentNode != nil && currentIndex < index {
			currentNode = currentNode?.next
			currentIndex += 1
		}

		return currentNode
	}
}

extension Node: CustomStringConvertible {
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

		return values.joined(separator: " <-> ")
	}
}
