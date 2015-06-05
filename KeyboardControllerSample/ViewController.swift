//
//  ViewController.swift
//  BestChem
//
//  Created by Oscar Chiu on 2015/5/23.
//  Copyright (c) 2015年 OscarChiu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, KeyboardControllerDelegate {

    let keyboardController = KeyboardController()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        keyboardController.delegate = self
        //Remember to set delegate of the UITextField or something...
        //keyboardController.animateDuration = 0.5  //(option)
        //keyboardController.spacing = 5  //(option)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getMainView() -> UIView {
        return self.view
    }
    
    // MARK: - Touch
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(false)
    }
    
    // MARK: - UITextFieldDelegate
    func textFieldDidBeginEditing(textField: UITextField) {
        keyboardController.didBeginEditing(textField)
    }
}

