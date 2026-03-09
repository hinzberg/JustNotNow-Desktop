//
//  ToDoRepositoryTests.swift
//  JustNotNowDesktopTests
//
//  Created by Cursor AI on 09.03.26.
//

import XCTest
@testable import JustNotNowDesktop

final class ToDoRepositoryTests: XCTestCase {

    var repository: ToDoRepository!

    override func setUpWithError() throws {
        repository = ToDoRepository()
    }

    override func tearDownWithError() throws {
    }

    func testInitialCounts() throws {
        XCTAssertEqual(repository.inboxItemsCount, 3, "Expected 3 inbox items with priority -1 in the default data set.")
        XCTAssertEqual(repository.backlogItemsCount, 1, "Expected 1 backlog item with priority 0 in the default data set.")
        XCTAssertEqual(repository.upNextItemsCount, 2, "Expected 2 up-next items with priority between 1 and 5 in the default data set.")

        XCTAssertEqual(repository.filteredInboxItems(matching: "").count, repository.inboxItemsCount)
        XCTAssertEqual(repository.filteredBacklogItems(matching: "").count, repository.backlogItemsCount)
        XCTAssertEqual(repository.filteredUpNextItems(matching: "").count, repository.upNextItemsCount)
    }

    func testAddAndDeleteInboxItem() {
        repository.clear()

        XCTAssertEqual(repository.inboxItemsCount, 0)

        let item = ToDoItem(itemDescription: "Test Inbox Item")
        repository.add(item)

        XCTAssertEqual(repository.inboxItemsCount, 1)
        XCTAssertEqual(repository.filteredInboxItems(matching: "").count, 1)

        repository.delete(item)

        XCTAssertEqual(repository.inboxItemsCount, 0)
        XCTAssertEqual(repository.filteredInboxItems(matching: "").count, 0)
    }

    func testToggleCompletion() {
        repository.clear()

        let item = ToDoItem(itemDescription: "Toggle Completion Item")
        repository.add(item)

        var items = repository.filteredInboxItems(matching: "")
        XCTAssertEqual(items.count, 1)
        XCTAssertFalse(items[0].isCompleted)

        repository.toggleCompletion(item)

        items = repository.filteredInboxItems(matching: "")
        XCTAssertEqual(items.count, 1)
        XCTAssertTrue(items[0].isCompleted)
    }

    func testAddOrUpdate() {
        repository.clear()

        var item = ToDoItem(itemDescription: "Original")
        repository.addOrUpdate(item)

        var items = repository.filteredInboxItems(matching: "")
        XCTAssertEqual(items.count, 1)
        XCTAssertEqual(items[0].itemDescription, "Original")

        item.itemDescription = "Updated"
        repository.addOrUpdate(item)

        items = repository.filteredInboxItems(matching: "")
        XCTAssertEqual(items.count, 1, "addOrUpdate should replace an existing item with the same id instead of adding a new one.")
        XCTAssertEqual(items[0].itemDescription, "Updated")
    }

    func testMoveToBacklogAndUpNext() {
        repository.clear()

        let item = ToDoItem(itemDescription: "Move Item")
        repository.add(item)

        XCTAssertEqual(repository.inboxItemsCount, 1)
        XCTAssertEqual(repository.backlogItemsCount, 0)
        XCTAssertEqual(repository.upNextItemsCount, 0)

        repository.moveToBacklog(item)

        XCTAssertEqual(repository.inboxItemsCount, 0)
        XCTAssertEqual(repository.backlogItemsCount, 1)
        XCTAssertEqual(repository.upNextItemsCount, 0)

        repository.moveToUpNext(item)

        XCTAssertEqual(repository.inboxItemsCount, 0)
        XCTAssertEqual(repository.backlogItemsCount, 0)
        XCTAssertEqual(repository.upNextItemsCount, 1)
    }

    func testAddSampleItem() {
        repository.clear()

        XCTAssertEqual(repository.inboxItemsCount, 0)
        XCTAssertEqual(repository.backlogItemsCount, 0)
        XCTAssertEqual(repository.upNextItemsCount, 0)

        repository.addSampleItem()

        XCTAssertEqual(repository.upNextItemsCount, 1, "Sample item should have a priority between 1 and 3, which belongs to the up-next list.")

        let items = repository.sortedByPriority()
        XCTAssertEqual(items.count, 1)
        let priority = items[0].priority
        XCTAssertTrue((1...3).contains(priority), "Sample item priority should be between 1 and 3, but was \(priority).")
    }

    func testFilteringByText() {
        repository.clear()

        let inboxItem1 = ToDoItem(itemDescription: "Buy Milk", priority: -1)
        let inboxItem2 = ToDoItem(itemDescription: "Walk the Dog", priority: -1)
        let backlogItem = ToDoItem(itemDescription: "Milk backup", priority: 0)

        repository.add(inboxItem1)
        repository.add(inboxItem2)
        repository.add(backlogItem)

        let filteredInboxMilk = repository.filteredInboxItems(matching: "milk")
        XCTAssertEqual(filteredInboxMilk.count, 1)
        XCTAssertEqual(filteredInboxMilk.first?.itemDescription, "Buy Milk")

        let filteredBacklogMilk = repository.filteredBacklogItems(matching: "milk")
        XCTAssertEqual(filteredBacklogMilk.count, 1)
        XCTAssertEqual(filteredBacklogMilk.first?.itemDescription, "Milk backup")
    }

    func testSortedByPriority() {
        repository.clear()

        let lowPriority = ToDoItem(itemDescription: "Low", priority: 1)
        let mediumPriority = ToDoItem(itemDescription: "Medium", priority: 3)
        let highPriority = ToDoItem(itemDescription: "High", priority: 5)

        repository.add(lowPriority)
        repository.add(mediumPriority)
        repository.add(highPriority)

        let sorted = repository.sortedByPriority()
        XCTAssertEqual(sorted.map { $0.itemDescription }, ["High", "Medium", "Low"])
    }
}
