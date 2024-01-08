//
//  QueueTests.swift
//  
//
//  Created by Илья Горяев on 08.01.2024.
//

import XCTest
@testable import DataStructures

final class QueueTests: XCTestCase {
	//MARK: - Stored properties
	
	private var sut: Queue<Int>!
	
	// MARK: - Override XCTestCase methods
	
	override func setUp() {
		makeSut()
	}
	
	override func tearDown() {
		sut = nil
	}
	
	// MARK: - Test methods
	
	func test_numberOfElements_withoutElements_queueShouldBeEmpty() {
		// Act
		let queueIsEmpty = sut.isEmpty
		
		// Assert
		XCTAssertTrue(queueIsEmpty, "Ошибка: очередь при инициализации должна быть пустой")
	}
	
	func test_enqueueElement_queueLenght_queueShouldNotBeEmpty() {
		// Act
		let valueToEnqueue = 1
		sut.enqueue(valueToEnqueue)
		let queueIsEmpty = sut.isEmpty
		
		// Assert
		XCTAssertTrue(!queueIsEmpty, "Ошибка: очередь при добавлении элемента не должна быть пустой")
	}
	
	func test_peekElement_queueValues_queueShouldReturnCorrectElement() {
		// Act
		sut.enqueue(1)
		sut.enqueue(2)
		sut.enqueue(3)
		
		let firstElementAtQueue = 1
		let peekedValue = sut.peek
		
		// Assert
		XCTAssertEqual(peekedValue, firstElementAtQueue, "Ошибка: неверное значение первого элемента в очереди")
	}
	
	func test_removeValue_queueValues_queueShouldDeleteAndReturnCorrectElement() {
		// Act
		sut.enqueue(1)
		sut.enqueue(2)
		sut.enqueue(3)
		
		let firstElementAtQueue = 1
		let lenghtBeforeRemoving = sut.count
		let deletedElement = sut.dequeue()
		let lenghtAfterRemoving = sut.count
		
		let expectedLength = lenghtBeforeRemoving - 1
		
		// Assert
		XCTAssertEqual(lenghtAfterRemoving, expectedLength, "Ошибка: длина очереди не соответствует ожидаемой")
		XCTAssertEqual(deletedElement, firstElementAtQueue, "Ошибка: неверное значение первого элемента в очереди")
	}
	
}

// MARK: - Private methods
private extension QueueTests {
	func makeSut() {
		sut = Queue()
	}
}
