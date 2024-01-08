import XCTest
@testable import DataStructures

final class DoubleLinkedListTests: XCTestCase {
	//MARK: - Stored properties
	
	private var sut: DoubleLinkedList<Int>!
	
	// MARK: - Override XCTestCase methods
	
	override func setUp() {
		makeSut()
	}
	
	override func tearDown() {
		sut = nil
	}
	
	// MARK: - Test methods
	
	func test_numberOfElements_withoutElements_doubleLinkedListShouldBeEmpty() {
		// Act
		let doubleLinkedListIsEmpty = sut.isEmpty
		
		//Assert
		XCTAssertTrue(doubleLinkedListIsEmpty, "Ошибка: двусвязный список при инициализации без параметров должен быть пустым")
	}
	
	func test_pushValue_doubleLinkedListValues_doubleLinkedListShouldNotBeEmpty() {
		// Act
		sut.push(1)
		let doubleLinkedListIsEmpty = sut.isEmpty
		
		// Assert
		XCTAssertTrue(!doubleLinkedListIsEmpty, "Ошибка, после добавления значения в начало двусвязного списка, он не должен быть пустым")
	}
					  
	func test_appendValue_doubleLinkedListValues_doubleLinkedListShouldNotBeEmpty() {
		// Act
		sut.append(1)
		let doubleLinkedListIsEmpty = sut.isEmpty
		
		// Assert
		XCTAssertTrue(!doubleLinkedListIsEmpty, "Ошибка, после добавления значения в конец двусвязного списка, он не должен быть пустым")
	}
	
	func test_appendAndPushValues_withOneValueToPushAndOneValueToAppend_doubleLinkedListShouldContainTwoElements() {
		// Act
		sut.append(1)
		sut.push(2)
		let doubleLinkedListLenght = sut.count
		let expectedResult = 2
		
		// Assert
		XCTAssertEqual(doubleLinkedListLenght, expectedResult, "Ошибка: количество элементов двусвязного списка не равно ожидаемум (2м)")
	}
	
	func test_getValueByIndex_withPositionIndex_doubleLinkedListShouldReturnValueAtCurrentPosition() {
		// Act
		sut.append(1)
		sut.append(2)
		sut.append(3)
		
		let currentIndex = 1
		let getValueByIndex = sut.value(at: currentIndex)
		let expectedResult = 2
		
		// Assert
		XCTAssertEqual(getValueByIndex, expectedResult, "Ошибка: неверное значение двусвязного списка по заданному индексу")
	}
	
	func test_addValueAfterCurrentIndex_withValueToAddAndWithIndex_doubleLinkedListShouldAddValueAfterCurrentIndex() {
		// Act
		sut.append(1)
		sut.append(2)
		sut.append(3)
		
		let valueToAdd = 4
		let index = 1
		sut.insert(valueToAdd, after: index)
		let getValueByIndex = sut.value(at: index + 1)
		let expectedResult = valueToAdd
		
		// Assert
		XCTAssertEqual(getValueByIndex, expectedResult, "Ошибка: неверное добавление элемента после указанного индекса")
	}
	
	func test_removeValueFromTop_doubleLinkedListValues_doubleLinkedListShouldDecreaseLenghtAndDeleteCorrectValue() {
		// Act
		sut.append(1)
		sut.append(2)
		sut.append(3)
		
		let lenghtBeforeRemoving = sut.count
		let popValue = sut.pop()
		let currentLenght = sut.count
		
		let valueAtTop = 1
		let expectedLength = lenghtBeforeRemoving - 1
		
		// Assert
		XCTAssertEqual(valueAtTop, popValue, "Ошибка: удаление неверного значение из начала списка")
		XCTAssertEqual(currentLenght, expectedLength, "Ошибка: длина двусвязного списка не соответствует ожидаемой")
	}
	
	func test_removeValueFromEnd_doubleLinkedListValues_doubleLinkedListShouldDecreaseLenghtAndDeleteCorrectValue() {
		// Act
		sut.append(1)
		sut.append(2)
		sut.append(3)
		
		let lenghtBeforeRemoving = sut.count
		let removeLastValue = sut.removeLast()
		let currentLenght = sut.count
		
		let valueAtEnd = 3
		let expectedLength = lenghtBeforeRemoving - 1
		
		// Assert
		XCTAssertEqual(valueAtEnd, removeLastValue, "Ошибка: удаление неверного значение из начала списка")
		XCTAssertEqual(currentLenght, expectedLength, "Ошибка: длина двусвязного списка не соответствует ожидаемой")
	}
	
	func test_removeValueAfterCurrentIndex_withIndex_doubleLinkedListShouldDecreaseLenghtAndDeleteCorrectValue() {
		// Act
		sut.append(1)
		sut.append(2)
		sut.append(3)
		sut.append(4)
		
		let lenghtBeforeRemoving = sut.count
		let index = 1
		let removeValue = sut.remove(after: index)
		let currentLenght = sut.count
		
		let valueAfterCurrentIndex = 3
		let expectedLength = lenghtBeforeRemoving - 1
		
		// Assert
		XCTAssertEqual(removeValue, valueAfterCurrentIndex, "Ошибка: удаление неверного элемента из середины списка")
		XCTAssertEqual(currentLenght, expectedLength, "Ошибка: длина двусвязного списка не соответствует ожидаемой")
		
	}
}

// MARK: - Private methods
private extension DoubleLinkedListTests {
	func makeSut() {
		sut = DoubleLinkedList()
	}
}
