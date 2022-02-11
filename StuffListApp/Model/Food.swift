//
//  Food.swift
//  StuffListApp
//
//  Created by Glynvile Satago on 2/9/22.
//

import Foundation

struct Food {
    var id: Int
    var name: String
    var price: Double
    var discountedPrice: Double
    var description: String
    var imageUrl: String
    var star: Int
    var category: String
    
    var ingredients: [String]?
    var allergens: [String]?
    
    init(data: Dictionary<String, Any>, category: String) {
        self.id = data["id"] as! Int
        self.name = data["title"] as! String
        self.price = data["price"] as! Double
        self.discountedPrice = data["discountedPrice"] as! Double
        self.description = data["description"] as! String
        self.imageUrl = data["imageUrl"] as! String
        self.star = data["star"] as! Int
        self.category = category
    }
}
