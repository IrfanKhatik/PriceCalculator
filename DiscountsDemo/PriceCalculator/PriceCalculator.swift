//
//  PriceCalculator.swift
//  DiscountsDemo
//
//  Created by Irfan Khatik on 20/11/18.
//  Copyright © 2018 Discounts. All rights reserved.
//

import Foundation

enum User {
    case Employee           // 30%
    case AffiliatedCustomer // 10%
    case LongTimeCustomer   // more than 2 years 5%
    case Other
}

enum PurchaseType {
    case Grocery    // No discount applied
    case Other      // Only one discount applied
}

class PriceCalculator {
    private let employeeDiscountPercentage              = 30
    private let affiliatedCustomerDiscountPercentage    = 10
    private let longTimeCustomerDiscountPercentage      = 5
    private let defaultDiscountPercentage               = 5
    
    private let MAX_VALUE = 9999
    private let MIN_VALUE = 1
    
    func calculateTotalPrice(for user:User, billAmount amount:Int, purchaseType item:PurchaseType) -> Int {
        if MIN_VALUE > amount || MAX_VALUE < amount {
            return amount
        }
        
        let totalPrice = amount
        switch item {
        case .Grocery:
            break
        case .Other:
            let discountAmount = calculateTotalDiscount(for: user, billAmount: amount)
            let discountedPrice = totalPrice - discountAmount
            return discountedPrice
        }
        
        return totalPrice
    }
    
    private func calculateTotalDiscount(for user:User, billAmount amount:Int) -> Int {
        var discountAmount = 0
        switch user {
        case .Employee:             // Apply 30%
            discountAmount = (employeeDiscountPercentage * amount) / 100
            break
        case .AffiliatedCustomer:   // Apply 10%
            discountAmount = (affiliatedCustomerDiscountPercentage * amount) / 100
            break
        case .LongTimeCustomer:     // Apply 5%
            discountAmount = (longTimeCustomerDiscountPercentage * amount) / 100
            break
        default:
            discountAmount = (defaultDiscountPercentage * hundredTimes(for: amount))
            break
        }
        
        return discountAmount
    }
    
    // Maximum range assumed 1 - 9999
    private func hundredTimes(for amount:Int)->Int {
        let thousands = (amount / 1000)
        let hundreds = (amount / 100) % 10
        return (thousands * 10) + hundreds
    }
}

