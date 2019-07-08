//
//  ViewController.swift
//  KeyboardNotification
//
//  Created by Thaliees on 7/8/19.
//  Copyright © 2019 Thaliees. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var labelText: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowNotification(keyboard:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHideNotification(keyboard:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: Keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField{
            nextField.becomeFirstResponder()
        }
        else {
            self.view.endEditing(true)
            updateLabel(text: textField.text!)
        }
        
        return false
    }
    
    @objc func keyboardWillShowNotification(keyboard: NSNotification){
        let userInfo = keyboard.userInfo
        let keyboardFrame = userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        self.view.frame.origin.y -= keyboardFrame.height
    }
    
    @objc func keyboardWillHideNotification(keyboard: NSNotification){
        self.view.frame.origin.y = 0
    }
    
    // MARK: Custom Methods
    func updateLabel(text:String) {
        labelText.text = text
        textField.text = ""
    }
}

