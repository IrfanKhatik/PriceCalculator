//
//  DiscountsDemoTests.swift
//  DiscountsDemoTests
//
//  Created by Irfan Khatik on 20/11/18.
//  Copyright © 2018 Discounts. All rights reserved.
//

import XCTest
@testable import DiscountsDemo

class DiscountsDemoTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNegativeAmount() {
        let calculator = PriceCalculator()
        let discountedAmount = calculator.calculateTotalPrice(for: .Other, billAmount: -1000, purchaseType: .Other)
        XCTAssertEqual(-1000, discountedAmount)
    }
    
    func testHundredsAmount() {
        let calculator = PriceCalculator()
        let discountedAmount = calculator.calculateTotalPrice(for: .Other, billAmount: 990, purchaseType: .Other)
        XCTAssertEqual(945, discountedAmount)
    }
    
    func testThousandsAmount() {
        let calculator = PriceCalculator()
        let discountedAmount = calculator.calculateTotalPrice(for: .Other, billAmount: 1990, purchaseType: .Other)
        XCTAssertEqual(1895, discountedAmount)
    }
    
    func testEmployeeAmount() {
        let calculator = PriceCalculator()
        let discountedAmount = calculator.calculateTotalPrice(for: .Employee, billAmount: 1000, purchaseType: .Other)
        XCTAssertEqual(700, discountedAmount)
    }
    
    func testAffiliatedCustomerAmount() {
        let calculator = PriceCalculator()
        let discountedAmount = calculator.calculateTotalPrice(for: .AffiliatedCustomer, billAmount: 1000, purchaseType: .Other)
        XCTAssertEqual(900, discountedAmount)
    }
    
    func testLongTimeCustomerAmount() {
        let calculator = PriceCalculator()
        let discountedAmount = calculator.calculateTotalPrice(for: .LongTimeCustomer, billAmount: 1000, purchaseType: .Other)
        XCTAssertEqual(950, discountedAmount)
    }

    func testOutOfRangeAmount() {
        let calculator = PriceCalculator()
        let discountedAmount = calculator.calculateTotalPrice(for: .Other, billAmount: 10000, purchaseType: .Other)
        XCTAssertEqual(10000, discountedAmount)
    }

}
