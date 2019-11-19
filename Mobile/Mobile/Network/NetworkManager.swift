//
//  DownloadJson.swift
//  Mobile
//
//  Created by Taras Beshley on 10/30/19.
//  Copyright © 2019 Taras Beshley. All rights reserved.
//

import Foundation
import SystemConfiguration

enum Result {
    case Seccess(data: [WaterInfo])
    case Fail(error: Error)
}

final class NetworkManager {
    
    //MARK: Property
    private let session: URLSession
    
    //MARK: Init
    init(timeout:TimeInterval = 30.0) {
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.timeoutIntervalForRequest = timeout
        sessionConfiguration.timeoutIntervalForResource = timeout
        session = URLSession(configuration: sessionConfiguration)
    }

    //MARK: Private Methods
    private func getWaterInfoUrl() -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = "localhost"
        urlComponents.port = 1337
        urlComponents.path = "/mob"
        return urlComponents.url
    }
    
    //MARK:Public Methods
    func getDataFromServer(complition: @escaping ((Result) -> Void)) {
        guard let url = getWaterInfoUrl() else { return }
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            guard let response = response as? HTTPURLResponse else { return }
            switch response.statusCode {
            case 200...204:
                guard let data = data else { return }
                guard let json = try? JSONDecoder().decode([WaterInfo].self, from: data) else { return }
                complition(.Seccess(data: json))
            default:
                guard let err = error else { return }
                complition(.Fail(error: err))
            }
        }.resume()
    }
    
    class func Connection() -> Bool {
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)
        return ret
    }
}


