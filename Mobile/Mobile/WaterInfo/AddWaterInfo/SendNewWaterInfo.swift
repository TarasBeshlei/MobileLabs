//
//  SendNewWaterInfo.swift
//  Mobile
//
//  Created by Taras Beshley on 12/4/19.
//  Copyright © 2019 Taras Beshley. All rights reserved.
//

import UIKit

enum ResultOfPost {
    case Seccess(data: String)
    case Fail(error: Error)
}

final class SendNewWaterInfo: UIViewController {

    //MARK: IBOutlet
    @IBOutlet weak var cityNameField: UITextField!
    @IBOutlet weak var coordinateField: UITextField!
    @IBOutlet weak var waterLevelField: UITextField!
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var cityNameLable: UILabel!
    @IBOutlet weak var coordinatesLable: UILabel!
    @IBOutlet weak var waterLevelLable: UILabel!
    @IBOutlet weak var dateLable: UILabel!
    
    //MARK: UIViews
    private lazy var progressIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    //MARK: Private Variables
    private var counterWhenValid = 0
    private var regularArr: [NSRegularExpression] = []
    private var textFiedlsList = [UITextField]()
    private var lablesList = [UILabel]()
    private var errorDict = [0: "Enter correct city name", 1: "Enter correct coordinates", 2: "Enter correct water level", 3: "Enter correcr date"]
    
    //MARK:  View controller lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNSRegularExpression()
    }
    
    //MARK: IBAction
    @IBAction func submitButton(_ sender: Any) {
        setUpProgresIndicator()
        allTextFieldsAreValid()
        if (counterWhenValid == 4) {
            postWaterData { [weak self] (result) in
                switch result {
                case .Seccess(let data):
                    DispatchQueue.main.async {
                        self!.progressIndicator.stopAnimating()
                    }
                case .Fail(let error):
                    print(error.localizedDescription)
                }
            }
            counterWhenValid = 0
        }
    }
    
    //MARK: Private Methods
    private func setUpProgresIndicator() {
        progressIndicator.center = self.view.center
        progressIndicator.hidesWhenStopped = true
        progressIndicator.style = UIActivityIndicatorView.Style.gray
        self.view.addSubview(progressIndicator)
        progressIndicator.startAnimating()
    }
    
    private func postWaterData(complition: @escaping ((ResultOfPost) -> Void)) {
        let parameters = ["cityName": "\(cityNameField.text!)", "coordinates": "\(coordinateField.text!)", "waterLevel": "\(waterLevelField.text!)", "date": "\(dateField.text!)", "imageURL": "https://gordonua.com/img/article/13465/21_tn.jpg"]
        guard let url = URL(string: "http://localhost:1337/form") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpdBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpdBody
        let session = URLSession.shared
        session.dataTask(with: request) {(data, response, error) in
            if let response = response {
                print(response)
            }
            complition(.Seccess(data: ""))
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                    
                } catch {
                    print(error)
                    complition(.Fail(error: error))
                }
            }
        }.resume()
    }
    
    private func validate(string: String, withRegex regex: NSRegularExpression) -> Bool {
        let range = NSRange(string.startIndex..., in: string)
        let matchRange = regex.rangeOfFirstMatch(in: string, options: .reportProgress, range: range)
        return matchRange.location != NSNotFound
    }
    
    private func setupNSRegularExpression() {
        textFiedlsList = [cityNameField, coordinateField, waterLevelField, dateField]
        lablesList = [cityNameLable, coordinatesLable, waterLevelLable, dateLable]
        let patterns = [".", "^[0-9]+$", "^[0-9]+$", "."]
        regularArr = patterns.map {
            do {
                let reg = try NSRegularExpression(pattern: $0, options: .caseInsensitive)
                return reg
            } catch {
                #if targetEnvironment(simulator)
                fatalError("Error initializing regular expressions. Exiting.")
                #else
                return nil
                #endif
            }
        }
    }
    
    private func allTextFieldsAreValid() -> Bool {
        for (index, textFiedls) in textFiedlsList.enumerated() {
            let regex = regularArr[index]
            guard let text = textFiedls.text else {
                print("Fail")
                return false
            }
            var b = validate(string: text, withRegex: regex)
            if (b == false){
                if(errorDict.keys.contains(index)) {
                    lablesList[index].text = errorDict[index]
                    Validation().validationIndication(inField: textFiedlsList[index])
                    counterWhenValid = 0
                }
            } else {
                Validation().borderStandartColor(inField: textFiedlsList[index])
                lablesList[index].text = ""
                counterWhenValid += 1
            }
        }
        if (counterWhenValid == 4){
            return false
        } else {
            return true
        }
    }
}
