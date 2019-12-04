//
//  WaterInfoModule.swift
//  Mobile
//
//  Created by Taras Beshley on 10/31/19.
//  Copyright © 2019 Taras Beshley. All rights reserved.
//

import Foundation

struct WaterInfo: Codable {
    let imageURL: URL
    let cityName: String
    let coordiantes: String
    let waterLevel: String
    let date: String
    
    private enum CodingKeys: String, CodingKey {
        case imageURL = "imageURL"
        case cityName = "cityName"
        case coordinates = "coordinates"
        case waterLevel = "waterLevel"
        case date = "date"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(imageURL, forKey: .imageURL)
        try container.encode(cityName, forKey: .cityName)
        try container.encode(coordiantes, forKey: .coordinates)
        try container.encode(waterLevel, forKey: .waterLevel)
        try container.encode(date, forKey: .date)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        imageURL = try container.decode(URL.self, forKey: .imageURL)
        cityName = try container.decode(String.self, forKey: .cityName)
        coordiantes = try container.decode(String.self, forKey: .coordinates)
        waterLevel = try container.decode(String.self, forKey: .waterLevel)
        date = try container.decode(String.self, forKey: .date)
    }
}
