//
//  TopTextFieldDelegate.swift
//  MemeMe
//
//  Created by Nathaniel Remy on 2017-06-01.
//  Copyright © 2017 Nathaniel Remy. All rights reserved.
//

import Foundation
import UIKit

class TopTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == "TOP" {
            textField.text = ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
