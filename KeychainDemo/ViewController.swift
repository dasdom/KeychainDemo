//
//  ViewController.swift
//  KeychainDemo
//
//  Created by dasdom on 10.08.14.
//  Copyright (c) 2014 Dominik Hauser. All rights reserved.
//

import UIKit
import DDHKeychain

class ViewController: UIViewController, UITextFieldDelegate {

    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        DDHKeychain.setPassword(textField.text, account: "SharedAccount")
        textField.resignFirstResponder()
        return false
    }

}

