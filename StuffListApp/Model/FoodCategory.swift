//
//  File.swift
//  StuffListApp
//
//  Created by Glynvile Satago on 2/9/22.
//

import Foundation

struct FoodCategory {
    var id: Int
    var title: String
    var imageUrl: String
    var foods: [Food] = [Food]()
    
    init(data: Dictionary<String, Any>) {
        self.id = data["id"] as! Int
        self.title = data["name"] as! String
        self.imageUrl = data["imageUrl"] as! String
        if let foods = data["foods"] as? Array<Dictionary<String, Any>> {
            for food in foods {
                let foodObj = Food(data: food, category: self.title)
                self.foods.append(foodObj)
            }
        }
    }
}
