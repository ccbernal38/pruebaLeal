//
//  mobiletestTests.swift
//  mobiletestTests
//
//  Created by Christian bernal on 6/07/20.
//  Copyright © 2020 Christian Bernal. All rights reserved.
//

import XCTest
import Alamofire
@testable import mobiletest

class mobiletestTests: XCTestCase{
    var expectation : XCTestExpectation?
    var sideBarManager : SideBarManager?
    var detailTransactionManager : DetailTransactionManager?
    
    override func setUp() {
        sideBarManager = SideBarManager()
        detailTransactionManager = DetailTransactionManager()
    }
    
    override func tearDown() {
        sideBarManager = nil
        detailTransactionManager = nil
    }
    
    func testGetTransactions() {
        sideBarManager?.getTransactions(callback: self)
        self.expectation = XCTestExpectation(description: "testGetTransactions")
        wait(for: [self.expectation!], timeout: 5)
    }
    
    func testGetUser(){
        detailTransactionManager?.getUser(userid: 1, callback: self)
        self.expectation = XCTestExpectation(description: "testGetUser")
        wait(for: [self.expectation!], timeout: 10)
        
    }
    
    func testGetDetailsTransaction(){
        detailTransactionManager?.getDetailTransaction(transactionId: 1, callback: self)
        self.expectation = XCTestExpectation(description: "testGetDetailsTransaction")
        wait(for: [self.expectation!], timeout: 10)
    }
}
extension mobiletestTests : MainManagerCallback{
    func onSuccess(transactions: [MainModel.Transaction]) {
        XCTAssert(transactions.count > 0)
        self.expectation!.fulfill()
        
    }
    
    func onError(message: String) {
        XCTAssert(false)
    }
}
extension mobiletestTests : DetailTransactionManagerCallback{
    func onError(message: String, error: HTTPURLResponse?) {
        if error != nil{
            XCTAssert(error?.statusCode == 404, message)
            self.expectation!.fulfill()
        }else{
            XCTAssert(false, message)
            self.expectation!.fulfill()
        }
    }
    
    func onSuccess(response: [String : Any]) {
        let serviceName = response["serviceName"] as! String
        if serviceName == "getDetailTransaction"{
            let detail = response["response"] as! DetailTransactionModel.Detail
            XCTAssertNotNil(detail)
            self.expectation!.fulfill()
            
        }else if serviceName == "getUser"{
            let user = response["response"] as! DetailTransactionModel.User
            XCTAssertNotNil(user)
            self.expectation!.fulfill()
            
        }
    }
}
