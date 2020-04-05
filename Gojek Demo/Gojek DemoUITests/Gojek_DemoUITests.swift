//
//  Gojek_DemoUITests.swift
//  Gojek DemoUITests
//
//  Created by Amol Prakash on 02/04/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import XCTest

class Gojek_DemoUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testContactListScreen() {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let myTable = app.tables.matching(identifier: "ContactListTableView")
        let cell = myTable.cells.element(matching: .cell, identifier: "ContactsTableViewCell").firstMatch
        XCTAssertTrue(cell.waitForExistence(timeout: 10))
        cell.tap()
        
        let contactButton = app.navigationBars["Contact Details"].buttons["Contacts"]
        XCTAssertTrue(contactButton.waitForExistence(timeout: 10))
        contactButton.tap()
    }
    
    func testContactDetailScreen() {
        let app = XCUIApplication()
        app.launch()
        
        let myTable = app.tables.matching(identifier: "ContactListTableView")
        let cell = myTable.cells.element(matching: .cell, identifier: "ContactsTableViewCell").firstMatch
        XCTAssertTrue(cell.waitForExistence(timeout: 10))
        cell.tap()
        
        app.navigationBars["Contact Details"].buttons["Edit"].tap()
        sleep(2)
        app.navigationBars["Edit Contact"].buttons["Cancel"].tap()
        sleep(2)
        app.buttons["MessageButton"].tap()
        sleep(1)
        app.buttons["CallButton"].tap()
        sleep(1)
        app.buttons["MailButton"].tap()
        sleep(1)
        app.buttons["FavouriteButton"].tap()
        sleep(3)
    }
    
    func testContactEditScreen() {
        let app = XCUIApplication()
        app.launch()
        
        let myTable = app.tables.matching(identifier: "ContactListTableView")
        let cell = myTable.cells.element(matching: .cell, identifier: "ContactsTableViewCell").firstMatch
        XCTAssertTrue(cell.waitForExistence(timeout: 10))
        cell.tap()
    
        app.navigationBars["Contact Details"].buttons["Edit"].tap()
        sleep(2)
        app.navigationBars["Edit Contact"].buttons["Cancel"].tap()
        sleep(2)
    }
    
    func testContactEditDoneScreen() {
        let app = XCUIApplication()
        app.launch()
        
        let myTable = app.tables.matching(identifier: "ContactListTableView")
        let cell = myTable.cells.element(matching: .cell, identifier: "ContactsTableViewCell").firstMatch
        XCTAssertTrue(cell.waitForExistence(timeout: 10))
        cell.tap()
    
        app.navigationBars["Contact Details"].buttons["Edit"].tap()
        sleep(2)
        let firstNameField = app.textFields["First Name"]
        if firstNameField.exists {
            firstNameField.tap()
            firstNameField.clearAndEnterText(text: "Amol")
        }
        let lastNameField = app.textFields["Last Name"]
        if lastNameField.exists {
            lastNameField.tap()
            lastNameField.clearAndEnterText(text: "Prakash")
        }
        app.navigationBars["Edit Contact"].buttons["Done"].tap()
        sleep(2)
    }
    
    func testContactAddScreen() {
        let app = XCUIApplication()
        app.launch()
        sleep(2)
        app.navigationBars["Contacts"].buttons["Add"].tap()
        sleep(2)
        
        let firstNameField = app.textFields["First Name"]
        if firstNameField.exists {
            firstNameField.tap()
            firstNameField.typeText("Aamol")
        }
        
        let lastNameField = app.textFields["Last Name"]
        if lastNameField.exists {
            lastNameField.tap()
            lastNameField.typeText("Prakash")
        }
        
        let phonNo = app.textFields["Phone Number"]
        if phonNo.exists {
            phonNo.tap()
            phonNo.typeText("+919568764532")
        }
        
        let email = app.textFields["Email Id"]
        if email.exists {
            email.tap()
            email.typeText("amolprakash@gmail.com")
        }
        
        app.navigationBars["Add Contact"].buttons["Done"].tap()
        sleep(2)
    }
}

extension XCUIElement {
    /**
     Removes any current text in the field before typing in the new value
     - Parameter text: the text to enter into the field
     */
    func clearAndEnterText(text: String) {
        guard let stringValue = self.value as? String else {
            XCTFail("Tried to clear and enter text into a non string value")
            return
        }

        self.tap()

        let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: stringValue.count)

        self.typeText(deleteString)
        self.typeText(text)
    }
}
