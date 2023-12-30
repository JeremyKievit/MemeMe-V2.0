//
//  textFieldDelegate.swift
//  MemeMe V1.0
//
//  Created by admin on 8/30/20.
//  Copyright © 2020 Com.JeremyKievit. All rights reserved.
//

import Foundation
import UIKit

class TextFieldDelegate: NSObject, UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == "Top" || textField.text == "Bottom" {
            textField.text = ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

