//
//  FoodCategoryViewModel.swift
//  StuffListApp
//
//  Created by Glynvile Satago on 2/9/22.
//

import Foundation

class FoodCategoryViewModel {
    private (set) var foodCategory: FoodCategory
    private (set) var foodViewModels = [FoodViewModel]()
    
    init(foodCategory: FoodCategory) {
        self.foodCategory = foodCategory
        
        for foodObj in foodCategory.foods {
            let foodVm = FoodViewModel(food: foodObj)
            self.foodViewModels.append(foodVm)
        }
    }
    
    func removeFoodViewModel(index: Int) -> FoodViewModel {
        return self.foodViewModels.remove(at: index)
    }
    
    func addFoodViewModel(index: Int, foodVm: FoodViewModel) {
        self.foodViewModels.insert(foodVm, at: index)
    }
    
    
}
