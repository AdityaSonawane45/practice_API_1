//
//  Products.swift
//  practice_API_1
//
//  Created by Mac on 29/02/24.
//

import Foundation
struct Object{
    let products: [Product]
    let total, skip, limit: Int
}

struct Product {
    let id: Int
    let title, description: String
    let price: Int
    let discountPercentage, rating: Double
    let stock: Int
    let brand, category: String
    let thumbnail: String
}

