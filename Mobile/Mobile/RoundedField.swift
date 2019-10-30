//
//  RoundedField.swift
//  Mobile
//
//  Created by Taras Beshley on 10/2/19.
//  Copyright © 2019 Taras Beshley. All rights reserved.
//

import UIKit

@IBDesignable
final class RoundedButton: UIButton {

    @IBInspectable
    var borderColor: UIColor = .clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable
    var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = 0
        }
    }
}
