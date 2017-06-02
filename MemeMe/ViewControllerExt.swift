//
//  ViewControllerExt.swift
//  MemeMe
//
//  Created by Nathaniel Remy on 2017-06-02.
//  Copyright © 2017 Nathaniel Remy. All rights reserved.
//

import Foundation
import UIKit

extension MemeEditorVC:  UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //When user has taken or chosen an image, the pickerView will dismiss and the imagePickerView will set it's image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            imagePickerView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
}
