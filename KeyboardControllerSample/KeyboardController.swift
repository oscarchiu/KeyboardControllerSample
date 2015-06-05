//
//  KeyboardController.swift
//  BestChem
//
//  Created by Oscar Chiu on 2015/6/5.
//  Copyright (c) 2015年 OscarChiu. All rights reserved.
//

import Foundation
import UIKit

protocol KeyboardControllerDelegate {
    func getMainView() -> UIView
}

class KeyboardController {
    var spacing: CGFloat = 3
    var animateDuration: NSTimeInterval = 0.3
    
    private var originY: CGFloat = 0
    private var editingView: UIView? = nil
    private var isKeyboardShow: Bool = false
    private var keyboardFrameEnd: CGRect = CGRectZero
    private var _delegate: KeyboardControllerDelegate?
    var delegate: KeyboardControllerDelegate? {
        get {
            return _delegate
        }
        set {
            _delegate = newValue
            if let mainView = _delegate?.getMainView() {
                self.originY = mainView.frame.origin.y
            }
            editingView = nil
            isKeyboardShow = false
            keyboardFrameEnd = CGRectZero
        }
    }
    
    init() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func scrollViewForKeyboradShowing() {
        if let editingViewFrame = self.editingView?.frame {
            let keyboardMinY = CGRectGetMinY(keyboardFrameEnd)
            if let mainView = delegate?.getMainView() {
                var editingMaxY = CGRectGetMaxY(editingViewFrame)
                editingMaxY = mainView.convertPoint(CGPointMake(0, editingMaxY), fromView: editingView?.superview).y
                var newY = self.originY - (editingMaxY - keyboardMinY + spacing);
                newY = newY > self.originY ? self.originY : newY
                UIView.animateWithDuration(animateDuration, animations: { () -> Void in
                    mainView.frame.origin.y = newY
                })
            }
        }
    }
    
    //MARK: - TextField
    func didBeginEditing(editingView: UIView) {
        self.editingView = editingView
        if isKeyboardShow {
            self.scrollViewForKeyboradShowing()
        }
    }
    
    //MARK: - Keyborad
    @objc func keyboardWillShow(notification: NSNotification) {
        let info  = notification.userInfo!
        let keyboardFrameEndObj: NSValue = info[UIKeyboardFrameEndUserInfoKey]! as! NSValue
        keyboardFrameEnd = keyboardFrameEndObj.CGRectValue()
        self.scrollViewForKeyboradShowing()
        
        isKeyboardShow = true
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let mainView = delegate?.getMainView() {
            UIView.animateWithDuration(animateDuration, animations: { () -> Void in
                mainView.frame.origin.y = self.originY
            })
        }
        isKeyboardShow = false
    }
}
