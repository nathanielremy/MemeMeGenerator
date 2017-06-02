//
//  ViewController.swift
//  MemeMe
//
//  Created by Nathaniel Remy on 2017-06-01.
//  Copyright © 2017 Nathaniel Remy. All rights reserved.
//

import UIKit

class MemeEditorVC: UIViewController {
    
    //MARK: UI Properties
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var photoLibraryButton: UIBarButtonItem!
    @IBOutlet weak var activityButton: UIBarButtonItem!
    @IBOutlet weak var topToolBar: UIToolbar!
    @IBOutlet weak var bottomStackView: UIStackView!
    
    //Delegates properties
    let topTextFieldDelegate = TopTextFieldDelegate()
    let bottomTextFieldDelegate = BottomTextFieldDelegate()

    override func viewDidLoad() {
        super.viewDidLoad()
        configuretextField(for: topTextField, withText: "TOP", delegate: topTextFieldDelegate)
        configuretextField(for: bottomTextField, withText: "BOTTOM", delegate: bottomTextFieldDelegate)
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
    
    // Open Photo Library or camera to select an image
    @IBAction func pickAnImage(_ sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sender == cameraButton ? .camera : .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    //MARK: Launch activity View
    @IBAction func launchActivityView(_ sender: Any) {
        let memedImage = generateMemedImage()
        let activityView = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        activityView.completionWithItemsHandler = { (activity, completed, items, error) in
            if completed {
                self.save()
            }
            
        }
        present(activityView, animated: true, completion: nil)
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
    
    func configuretextField(for textField: UITextField, withText text: String, delegate: UITextFieldDelegate) {
        // TextField text attributes
        let memeTextAttributes:[String:Any] = [
            NSStrokeColorAttributeName: UIColor.black,
            NSForegroundColorAttributeName: UIColor.white,
            NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName: -2
        ]
        
        textField.text = text
        textField.autocapitalizationType = .allCharacters
        textField.borderStyle = .none
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .center
        textField.delegate = delegate
    }
    
    //Add observers for keyboard showing and removal
    func addNotificationCenterObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(MemeEditorVC.keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(MemeEditorVC.keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
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
        
        hideViews(views: [topToolBar, bottomStackView], true)
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        hideViews(views: [topToolBar, bottomStackView], false)
        
        return memedImage
    }
    
    func hideViews(views: [UIView], _ hide: Bool) {
        for view in views {
            view.isHidden = hide
        }
    }
}
