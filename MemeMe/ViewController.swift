//
//  ViewController.swift
//  MemeMe
//
//  Created by Nathaniel Remy on 2017-06-01.
//  Copyright © 2017 Nathaniel Remy. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: UI Properties
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var activityButton: UIBarButtonItem!
    @IBOutlet weak var topToolBar: UIToolbar!
    @IBOutlet weak var bottomStackView: UIStackView!
    
    //Delegates properties
    let topTextFieldDelegate = TopTextFieldDelegate()
    let bottomTextFieldDelegate = BottomTextFieldDelegate()

    override func viewDidLoad() {
        super.viewDidLoad()
        configuretextFields()
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        addNotificationCenterObservers()
        
        if imagePickerView.image == nil {
            activityButton.isEnabled = false
        } else {
            activityButton.isEnabled = true
            view.backgroundColor = .white
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeNotificationCenterObservers()
    }
    
    //When user has taken or chosen an image, the pickerView will dismiss and the imagePickerView will set it's image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            imagePickerView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
    //Open PhotoLibrary to select an image
    @IBAction func pickAnImage(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func takeAnImage(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    //Function to call when keyBoardWillShow
    func keyboardWillShow(_ notification: Notification) {
        if bottomTextField.isFirstResponder {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= getKeyboardHeight(notification)
            }
        }
    }
    
    //Function to call when keyboardWillHide
    func keyboardWillHide() {
        self.view.frame.origin.y = 0
    }
    
    // Returns the height of the keyboard so that we can move the view when it shows
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
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
    
    //Add observers for keyboard showing and removal
    func addNotificationCenterObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
    }
    
    //Remove observers for keyboard showing and removal
    func removeNotificationCenterObservers() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    func save() {
        let _ = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imagePickerView.image!, memedImage: generateMemedImage())
    }
    
    //Generate a meme by configuring the view
    func generateMemedImage() -> UIImage {
        
        topToolBar.isHidden = true
        bottomStackView.isHidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        topToolBar.isHidden = false
        bottomStackView.isHidden = false
        
        return memedImage
    }
    
    //MARK: Launch activity View
    @IBAction func launchActivityView(_ sender: Any) {
        let memedImage = generateMemedImage()
        let activityView = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        activityView.completionWithItemsHandler = { _ in
            self.save()
        }
        present(activityView, animated: true, completion: nil)
        
    }
}
