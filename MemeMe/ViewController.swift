//
//  ViewController.swift
//  MemeMe
//
//  Created by Nathaniel Remy on 2017-06-01.
//  Copyright © 2017 Nathaniel Remy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: UI Properties
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    
    //Delegates properties
    let topTextFieldDelegate = TopTextFieldDelegate()
    let bottomTextFieldDelegate = BottomTextFieldDelegate()

    override func viewDidLoad() {
        super.viewDidLoad()
        configuretextFields()
    }
    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        print(info)
//    }
    
    //Open PhotoLibrary to select an image
    @IBAction func pickAnImage(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    
    
    
    
    func configuretextFields() {
        // TextField text attributes
        let memeTextAttributes:[String:Any] = [
            NSStrokeColorAttributeName: UIColor.black,
            NSForegroundColorAttributeName: UIColor.white,
            NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName: -2
        ]
        
        topTextField.text = "TOP"
        topTextField.autocapitalizationType = .allCharacters
        topTextField.borderStyle = .none
        topTextField.defaultTextAttributes = memeTextAttributes
        topTextField.textAlignment = .center
        topTextField.delegate = topTextFieldDelegate
        
        bottomTextField.text = "BOTTOM"
        bottomTextField.autocapitalizationType = .allCharacters
        bottomTextField.borderStyle = .none
        bottomTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.textAlignment = .center
        bottomTextField.delegate = bottomTextFieldDelegate
    }
}

