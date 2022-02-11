//
//  MainListTableViewController.swift
//  StuffListApp
//
//  Created by Glynvile Satago on 2/9/22.
//

import UIKit

class MainListTableViewController: UITableViewController {

    var categories = Array<FoodCategoryViewModel>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Menu"
        
        self.tableView.register(UINib(nibName: "MainTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        self.tableView.register(UINib(nibName: "MainHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "Header")
        
        self.tableView.dragInteractionEnabled = true
        self.tableView.dragDelegate = self
        
        self.readJson()
    }
    
    // Read the Food Json file
    func readJson() {
        guard let jsonFile = Bundle.main.url(forResource: "foodgallery", withExtension: "json") else { return }
        
        do {
            let data = try Data(contentsOf: jsonFile)
            if let info = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? Dictionary<String, Any>, let categories = info["categories"] as? Array<Dictionary<String, Any>> {
                for category in categories {
                    let categoryObj = FoodCategory(data: category)
                    
                    let categoryVm = FoodCategoryViewModel(foodCategory: categoryObj)
                    self.categories.append(categoryVm)
                    
                }
            }
        }
        catch (let exception) {
            debugPrint("Reading JSON exception: \(exception)")
        }
    }
    
    // Push to Detail View
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailTableViewController {
            destination.foodViewModel = sender as? FoodViewModel
        }
    }

}

extension MainListTableViewController: UITableViewDragDelegate, UITableViewDropDelegate {
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = categories[indexPath.section]
        let food = category.foodViewModels[indexPath.row]
        self.performSegue(withIdentifier: "showDetail", sender: food)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return categories.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let foods = categories[section].foodViewModels
        return foods.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MainTableViewCell
        let category = categories[indexPath.section]
        let foodVm = category.foodViewModels[indexPath.row]
        cell.foodViewModel = foodVm
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "Header") as? MainHeaderView
        let category = categories[section]
        
        headerView?.lblCategory.text = " " + category.foodCategory.title + " " 
        headerView?.imgBackground.image = UIImage(named: category.foodCategory.imageUrl)
    
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 120.0
    }
    
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        // not applicable
    }
    
    // MARK: Drag and Drop
    
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let dragItem = UIDragItem(itemProvider: NSItemProvider())
        return [dragItem]
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        guard sourceIndexPath != destinationIndexPath else { return }
        
        let fromCategory = categories[sourceIndexPath.section]
        let toCategory = categories[destinationIndexPath.section]
        
        tableView.beginUpdates()
        let foodVm = fromCategory.removeFoodViewModel(index: sourceIndexPath.row)
        toCategory.addFoodViewModel(index: destinationIndexPath.row, foodVm: foodVm)
        tableView.moveRow(at: sourceIndexPath, to: destinationIndexPath)
        tableView.endUpdates()
    }
    
    
}
