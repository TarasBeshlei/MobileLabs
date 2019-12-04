//
//  WaterInfoTable.swift
//  Mobile
//
//  Created by Taras Beshley on 10/20/19.
//  Copyright © 2019 Taras Beshley. All rights reserved.
//

import UIKit
import SDWebImage
import MaterialComponents.MaterialSnackbar

var arrayOfWaterInfoDecoded = [WaterInfo]()
var cellIndex = 0

final class WaterInfoTable: UIViewController {
    
    //MARK: Outlets
    @IBOutlet private weak var tableView: UITableView!
    
    //MARK: UIViews
    private lazy var progressIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    private lazy var refresh: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(refreshList), for: .valueChanged)
        return refreshControl
    }()
    
    //MARK: Variables
    let networkManager = NetworkManager()
    
    //MARK:  View controller lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewCOntroller()
    }
    
    //MARK: Private Methods
    private func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.refreshControl = refresh
    }
    
    private func setUpViewCOntroller() {
        setUpTableView()
        setUpProgresIndicator()
        fetchData()
    }
    
    private func setUpProgresIndicator() {
        progressIndicator.center = self.view.center
        progressIndicator.hidesWhenStopped = true
        progressIndicator.style = UIActivityIndicatorView.Style.white
        self.view.addSubview(progressIndicator)
        progressIndicator.startAnimating()
    }
    
    private func fetchData() {
        networkManager.getDataFromServer { [weak self] (result) in
            switch result {
            case .Seccess(let data):
                arrayOfWaterInfoDecoded = data
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    self!.progressIndicator.stopAnimating()
                }
            case .Fail(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    @objc
    private func refreshList() {
        networkManager.getDataFromServer { [weak self] (result) in
            switch result {
            case .Seccess(let data):
                arrayOfWaterInfoDecoded = data
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    self!.progressIndicator.stopAnimating()
                }
            case .Fail(let error):
                print(error.localizedDescription)
                self?.sneckBarPush(messageText: "Error while get data from server.")
            }
        }
        
        let deadline = DispatchTime.now() + .milliseconds(500)
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            self.refresh.endRefreshing()
            if NetworkManager.Connection() {
                
            } else {
                self.sneckBarPush(messageText: "No Connection")
            }
        }
    }
    
    private func sneckBarPush(messageText: String) {
        let message = MDCSnackbarMessage()
        message.text = messageText
        MDCSnackbarManager.show(message)
    }
}

//MARK: UITableViewDelegate
extension WaterInfoTable: UITableViewDelegate {}

//MARK: UITableViewDataSource
extension WaterInfoTable: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfWaterInfoDecoded.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell") as! WaterInfoCell
        let data = arrayOfWaterInfoDecoded[indexPath.row]
        
        cell.imageViewCell.sd_setImage(with: data.imageURL, placeholderImage: nil)
        cell.cityNameLable.text = "City Name: " + data.cityName
        cell.coordinatesLable.text = "Coordiantes: " + data.coordiantes
        cell.waterLevelLabel.text = "Water Level: " + data.waterLevel
        cell.dateLable.text = "Date: " + data.date
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cellIndex = indexPath.row
        performSegue(withIdentifier: "CellDetail", sender: self)
    }

}

