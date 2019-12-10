//
//  EmptyTableController.swift
//  Mobile
//
//  Created by Taras Beshley on 12/2/19.
//  Copyright © 2019 Taras Beshley. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialButtons

class EmptyTableController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let plusImage = UIImage(named: "no-image")!.withRenderingMode(.alwaysTemplate)
        let button = MDCFloatingButton()
        button.setImage(plusImage, for: .normal)
    }
}
