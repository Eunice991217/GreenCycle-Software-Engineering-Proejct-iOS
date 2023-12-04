//
//  ServerDataModel.swift
//  GreenCycle
//
//  Created by 김민경 on 12/4/23.
//

import Foundation

struct DataModelElement: Codable {
    let id: Int
    let latitude, longitude: Double
    let address: String
}
