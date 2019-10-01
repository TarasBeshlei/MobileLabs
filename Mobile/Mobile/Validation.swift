//
//  ValidationFile.swift
//  Mobile
//
//  Created by Taras Beshley on 9/20/19.
//  Copyright © 2019 Taras Beshley. All rights reserved.
//

import Foundation
import UIKit

final class Validation {

    //MARK: Public Methods
    public func fieldsSlideDown(inField: UITextField) {
        UIView.animate(withDuration: 0.1, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            inField.center.y += 20
        }, completion: nil)
    }
    
    public func fieldsSlideUp(inField: UITextField) {
        UIView.animate(withDuration: 0.1, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            inField.center.y -= 20
        }, completion: nil)
    }
    
    public func errorFieldMessageAnimateDown(inField: UILabel!) {
        UIView.animate(withDuration: 0.1, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            inField.center.y += 20
        }, completion: nil)
    }
    
    public func errorFieldMessageAnimationUp(inField: UILabel!) {
        UIView.animate(withDuration: 0.1, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            inField.center.y -= 20
        }, completion: nil)
    }
    
    public func validationIndication(inField: UITextField) {
        inField.layer.borderColor = UIColor.red.cgColor
        inField.layer.borderWidth = 1.0
        inField.layer.cornerRadius = 3
        
        UIView.animate(withDuration: 0.1, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            inField.center.x += 10
        }, completion: nil)
        
        UIView.animate(withDuration: 0.1, delay: 0.1, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            inField.center.x -= 20
        }, completion: nil)
        
        UIView.animate(withDuration: 0.1, delay: 0.2, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            inField.center.x += 10
        }, completion: nil)
    }
    
    public func borderStandartColor(inField: UITextField) {
        inField.layer.borderColor = UIColor.darkGray.cgColor
        inField.layer.borderWidth = 1.0
        inField.layer.cornerRadius = 3
    }
}
