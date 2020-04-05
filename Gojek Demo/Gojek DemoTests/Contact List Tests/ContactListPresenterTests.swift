//
//  ContactListPresenterTests.swift
//  Gojek DemoTests
//
//  Created by Amol Prakash on 04/04/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import XCTest
@testable import Gojek_Demo

class ContactListPresenterTests: XCTestCase {
    
    var presenter: ContactListPresenter?
    var mockView: MockContactListView?
    var mockInteractor: MockContactListInteractor?
    var mockRouter: MockContactListRouter?
    var dataFetcher: MockContactListDataFetcher?

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.presenter = ContactListPresenter()
        self.mockInteractor = MockContactListInteractor()
        self.mockRouter = MockContactListRouter()
        self.dataFetcher = MockContactListDataFetcher()
        
        let view = MockContactListView()
        self.mockView = view
        view.presenter = self.presenter
        
        self.presenter?.interactor = self.mockInteractor
        self.presenter?.view = view
        self.presenter?.router = self.mockRouter
        
        self.mockInteractor?.presenter = self.presenter
        self.mockInteractor?.remoteDataFetcher = self.dataFetcher
        
        self.dataFetcher?.interactor = self.mockInteractor
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.presenter = nil
        self.mockInteractor = nil
        self.mockRouter = nil
        self.dataFetcher = nil
        self.mockView = nil
        super.tearDown()
    }
    
    func testNumberOfRowsInSection() {
        self.presenter?.isGroupedList = true
        self.presenter?.viewDidLoad()
        XCTAssertEqual(self.presenter?.numberOfRows(inSection: 0), 2)
        
        self.presenter?.isGroupedList = false
        self.presenter?.viewDidLoad()
        XCTAssertEqual(self.presenter?.numberOfRows(inSection: 0), 4)
    }
    
    func testNumberOfSections() {
        self.presenter?.isGroupedList = true
        self.presenter?.viewDidLoad()
        XCTAssertEqual(self.presenter?.numberOfSection(), 3)
        
        self.presenter?.isGroupedList = false
        self.presenter?.viewDidLoad()
        XCTAssertEqual(self.presenter?.numberOfSection(), 1)
    }
    
    func testContactAtIndex() {
        self.presenter?.isGroupedList = true
        self.presenter?.viewDidLoad()
        let contact1 = self.presenter?.contactAt(indexPath: IndexPath(item: 0, section: 1))
        XCTAssertEqual(contact1?.contactId, 12123)
        
        self.presenter?.isGroupedList = false
        self.presenter?.viewDidLoad()
        let contact2 = self.presenter?.contactAt(indexPath: IndexPath(item: 1, section: 0))
        XCTAssertEqual(contact2?.contactId, 12121)
    }
    
    func testTitleStringForHeader() {
        self.presenter?.isGroupedList = true
        self.presenter?.viewDidLoad()
        XCTAssertEqual(self.presenter?.titleForHeader(in: 0), "A")
        XCTAssertEqual(self.presenter?.titleForHeader(in: 2), "D")
        
        self.presenter?.isGroupedList = false
        self.presenter?.viewDidLoad()
        XCTAssertEqual(self.presenter?.titleForHeader(in: 0), "")
    }
    
    func testSectionIndexTitles() {
        self.presenter?.isGroupedList = true
        self.presenter?.viewDidLoad()
        XCTAssertEqual(self.presenter?.sectionIndexTitles().count, 3)
        XCTAssertEqual(self.presenter?.sectionIndexTitles().first, "A")
        XCTAssertEqual(self.presenter?.sectionIndexTitles().last, "D")
        
        self.presenter?.isGroupedList = false
        self.presenter?.viewDidLoad()
        XCTAssertEqual(self.presenter?.sectionIndexTitles().count, 0)
    }
    
    func testSelectedContact() {
        self.presenter?.isGroupedList = true
        self.presenter?.viewDidLoad()
        self.presenter?.selectedRowAt(indexPath: IndexPath(item: 1, section: 0))
        XCTAssertEqual(self.mockRouter?.detailScreenCalled, true)
    }
    
    func testAddContact() {
        self.presenter?.addContact()
        XCTAssertEqual(self.mockRouter?.addScreenCalled, true)
    }
    
    func testContactAdded() {
        self.presenter?.isGroupedList = true
        self.presenter?.viewDidLoad()
        self.presenter?.didAdded(contact: conatct)
        XCTAssertEqual(self.presenter?.numberOfSection(), 4)
        
        self.presenter?.isGroupedList = false
        self.presenter?.viewDidLoad()
        self.presenter?.didAdded(contact: conatct)
        XCTAssertEqual(self.presenter?.numberOfRows(inSection: 0), 5)
    }
    
    func testLoaderShowHide() {
        self.presenter?.isGroupedList = false
        self.presenter?.viewDidLoad()
        self.presenter?.selectedRowAt(indexPath: IndexPath(item: 1, section: 0))
        XCTAssertEqual(self.mockView?.shown, true)
        XCTAssertEqual(self.mockView?.hide, true)
        
    }
    
    func testLoadingCompleted() {
        self.presenter?.viewDidLoad()
        XCTAssertEqual(self.mockView?.loadingComplete, true)
    }
    
    func testMarkedFavourite() {
        self.presenter?.contactMarkedFavourite()
        XCTAssertEqual(self.mockView?.loadingComplete, true)
    }
    
    func testContactInfoChanged() {
        self.presenter?.isGroupedList = false
        self.presenter?.viewDidLoad()
        let firstContact = self.presenter?.contactAt(indexPath: IndexPath(item: 0, section: 0))
        XCTAssertEqual(firstContact?.firstName, "Amit")
        firstContact?.firstName = "Mahesh"
        self.presenter?.contactInfoDidChange(isSortingRequired: true)
        let newFirstContact = self.presenter?.contactAt(indexPath: IndexPath(item: 0, section: 0))
        XCTAssertEqual(newFirstContact?.firstName, "Amol")
        
        self.presenter?.viewDidLoad()
        let anotherFirstContact = self.presenter?.contactAt(indexPath: IndexPath(item: 0, section: 0))
        XCTAssertEqual(anotherFirstContact?.firstName, "Amit")
        anotherFirstContact?.firstName = "Mahesh"
        self.presenter?.contactInfoDidChange(isSortingRequired: false)
        let newAnotherFirstContact = self.presenter?.contactAt(indexPath: IndexPath(item: 0, section: 0))
        XCTAssertEqual(newAnotherFirstContact?.firstName, "Mahesh")
    }
    
    func testShowError() {
        self.presenter?.onError(nil)
        XCTAssertEqual(self.mockView?.hide, true)
        XCTAssertEqual(self.mockView?.isError, true)
    }
}

