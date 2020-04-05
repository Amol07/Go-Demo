//
//  ContactListInteractorTests.swift
//  Gojek DemoTests
//
//  Created by Amol Prakash on 05/04/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import XCTest
@testable import Gojek_Demo

class ContactListInteractorTests: XCTestCase {

    var interactor: ContactListInteractor?
    var dataFetcher: MockContactListDataFetcher?
    var presenter: MockContactListPresenter?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.interactor = ContactListInteractor()
        self.dataFetcher = MockContactListDataFetcher()
        self.presenter = MockContactListPresenter()
        
        self.interactor?.presenter = self.presenter
        self.interactor?.remoteDataFetcher = self.dataFetcher
        self.dataFetcher?.interactor = self.interactor
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.interactor = nil
        self.presenter = nil
        self.dataFetcher = nil
        super.tearDown()
    }
    
    func testRetrieveContactList() {
        self.interactor?.retrieveContactList()
        XCTAssertEqual(self.presenter?.contacts?.count, 4)
    }
    
    func testGetContactDetails() {
        self.interactor?.getContactDetails(forContact: conatct)
        XCTAssertEqual(self.presenter?.contact?.contactId, 121211)
    }
}
