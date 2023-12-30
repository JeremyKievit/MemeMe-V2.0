//
//  MemeEditorVC.swift
//  MemeMe V1.0
//
//  Created by admin on 8/24/20.
//  Copyright © 2020 Com.JeremyKievit. All rights reserved.
//

import UIKit

class MemeEditorVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet var toolBar: UIToolbar!
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet var cameraButton: UIButton!
    @IBOutlet var textFieldTop: UITextField!
    @IBOutlet var textFieldBottom: UITextField!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    let textFieldDelegate = TextFieldDelegate() // Custom object
    
    
    // MARK: App state
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        shareButton.isEnabled = false
        subscribeToKeyboardNotifications()
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    
    override func viewDidLoad() {
           super.viewDidLoad()
        configure(textFieldTop, with: "Top")
        configure(textFieldBottom, with: "Bottom")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    
    // MARK: Text fields
    
    // Meme text which appears over the uploaded image
    
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth:  -3.0
    ]
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
          textField.resignFirstResponder()
          return true
      }
    
    func configure(_ textField: UITextField, with defaultText: String) {
        textField.text = defaultText
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .center
        textField.delegate = textFieldDelegate
    }
    
    
    // MARK: Recieving an image
    
    func pickAnImage(source: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = source
        self.present(imagePicker, animated: true, completion: nil)
    }

    @IBAction func pickAnImageFromAlbum(_ sender: Any) {
        pickAnImage(source: .photoLibrary)
    }

    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        pickAnImage(source: .camera)
    }
    
    internal func imagePickerController(_: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Delegate method for handling the event where an image is picked
        
          if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                imagePickerView.image = image
            }
          shareButton.isEnabled = true
          dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_: UIImagePickerController) {
              dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: Adjust view to keyboard hieght
    
   func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillShow(_ notification:Notification) {
        if textFieldBottom.isFirstResponder {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }

    @objc func keyboardWillHide(_ notification:Notification) {
        view.frame.origin.y = 0
    }

    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    
    // MARK: Generate and save
    
     @IBAction func share(_ sender: Any) {
        // Displays an Apple UIActivityView so users can share or download to their device
         
        let memedImage = generateMemedImage()
        let controller = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        controller.completionWithItemsHandler = { (activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) -> Void in
            if completed == true {
                // The meme is saved to the app if the UIActivityView is successfull
                
                self.save()
                self.dismiss(animated: true, completion: nil)
            }
        }
         
        self.present(controller, animated: true, completion: nil)
     }
    
    func generateMemedImage() -> UIImage {
        // Capture the newly created meme and return it as an image
        
        toolBar.isHidden = true

        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        toolBar.isHidden = false
        
        return memedImage
    }
    
    func save() {
        // Saves the meme to a global memes array in the app delegate
        
        let meme = Meme(topText: textFieldTop.text!, bottomText: textFieldBottom.text!, originalImage: imagePickerView.image!, memedImage: generateMemedImage())
        
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadTableData"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadCollectionData"), object: nil)
    }
}
