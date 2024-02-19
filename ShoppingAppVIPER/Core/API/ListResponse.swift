//
//  FirstListModel.swift
//
//  Created by Asya Atpulat on 25.10.2023.
//

import Foundation

struct ListResponse: Codable {
    let isSuccess: Bool?
    let message: String?
    let statusCode: String?
    let list: [List]?
}

struct List: Codable {
    let imageUrl: String?
    let description: String?
    let price: Price?
    let oldPrice: Price?
    let discount: String?
    let ratePercentage: Int?
}

struct Price: Codable {
    let value: Double?
    let currency: String?
}
