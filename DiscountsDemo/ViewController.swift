//
//  ViewController.swift
//  DiscountsDemo
//
//  Created by Irfan Khatik on 20/11/18.
//  Copyright © 2018 Discounts. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    fileprivate let userTypes = ["Employee", "AffiliatedCustomer", "LongTimeCustomer", "Other"]
    fileprivate let purchaseTypes = ["Non-Grocery", "Grocery"]
    
    fileprivate var isUserType = false
    fileprivate var selectedUserType:User? = nil
    fileprivate var selectedPurchaseType:PurchaseType? = nil
    
    @IBOutlet fileprivate weak var txtBillAmount: UITextField!
    @IBOutlet fileprivate weak var txtUserType: UITextField!
    @IBOutlet fileprivate weak var txtPurchaseType: UITextField!
    
    @IBOutlet fileprivate weak var lblBillAmount: UILabel!
    @IBOutlet fileprivate weak var lblDiscountAmount: UILabel!
    @IBOutlet fileprivate weak var lblDiscountedAmount: UILabel!
    
    @IBOutlet fileprivate weak var pickerType: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction private func calculateDiscountedAmount(_ sender: Any) {
        pickerType.isHidden = true
        guard let text = txtBillAmount.text, !text.isEmpty else {
            // Bill amount not added
            return
        }
        
        guard let user = selectedUserType else { return }
        guard let purchase = selectedPurchaseType else { return }
        
        let priceCalculator = PriceCalculator()
        let discountedAmount = priceCalculator.calculateTotalPrice(for: user, billAmount: (Int(text) ?? 0), purchaseType: purchase)
        lblBillAmount.text = text
        lblDiscountAmount.text = "-" + String((Int(text) ?? 0) - discountedAmount)
        lblDiscountedAmount.text = String(discountedAmount)
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        pickerType.isHidden = true
        if textField != txtBillAmount {
            txtBillAmount.resignFirstResponder()
        }
        
        switch textField {
        case txtUserType:
            isUserType = true
            pickerType.reloadAllComponents()
            pickerType.isHidden = false
            return false
        case txtPurchaseType:
            isUserType = false
            pickerType.reloadAllComponents()
            pickerType.isHidden = false
            return false
        case txtBillAmount:
            pickerType.isHidden = true
            return true
        default:
            pickerType.isHidden = true
            return true
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text, textField == txtBillAmount {
            if text.count == 1, string == "" {
                textField.text = ""
                textField.resignFirstResponder()
            } else if textField.text?.count == 3, string != "" {
                textField.text = text + string
                textField.resignFirstResponder()
            }
        }
        
        return true
    }
}

extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if isUserType {
            return userTypes.count
        } else {
            return purchaseTypes.count
        }
    }
}

extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if isUserType {
            return userTypes[row]
        } else {
            return purchaseTypes[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if isUserType {
            switch row {
            case 0: // Employee
                selectedUserType = .Employee
                break
            case 1: // Affiliated Customer
                selectedUserType = .AffiliatedCustomer
                break
            case 2: // Long Time Customer (more than 2 years)
                selectedUserType = .LongTimeCustomer
                break
            default:
                selectedUserType = .Other
                break
            }
            txtUserType.text = userTypes[row]
        } else {
            switch row {
            case 0: // Non-Grocery
                selectedPurchaseType = .Other
                break
            case 1: // Grocery
                selectedPurchaseType = .Grocery
                break
            default:
                selectedPurchaseType = .Other
            }
            txtPurchaseType.text = purchaseTypes[row]
        }
    }
}

