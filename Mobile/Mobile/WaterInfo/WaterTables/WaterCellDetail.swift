//
//  CellDetail.swift
//  Mobile
//
//  Created by Taras Beshley on 11/12/19.
//  Copyright © 2019 Taras Beshley. All rights reserved.
//

import UIKit

class CellDetail: UIViewController {

    @IBOutlet weak var imageFromCell: UIImageView!
    @IBOutlet weak var cityLable: UILabel!
    @IBOutlet weak var coordinateLable: UILabel!
    @IBOutlet weak var waterLevelLable: UILabel!
    @IBOutlet weak var dateLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInfoInOutlets() 
    }

    func setInfoInOutlets() {
        let data = arrayOfWaterInfoDecoded[cellIndex]
        imageFromCell.sd_setImage(with: data.imageURL, placeholderImage: nil)
        cityLable.text = "City: " + data.cityName
        coordinateLable.text = "Coordinates: " + data.coordiantes
        waterLevelLable.text = "Water level: " + data.waterLevel
        dateLable.text = "Date: " + data.date
    }

}
