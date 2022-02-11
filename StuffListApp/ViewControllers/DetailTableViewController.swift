//
//  DetailTableViewController.swift
//  StuffListApp
//
//  Created by Glynvile Satago on 2/10/22.
//

import UIKit

class DetailTableViewController: UITableViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblDiscount: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var foodViewModel: FoodViewModel!
    
    var moreFoods = Array<Dictionary<String, String>>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = foodViewModel.food.category
        
        // Add dummy loading
        self.activityView.hidesWhenStopped = true
        self.activityView.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            
            self.activityView.stopAnimating()
            
            // Add dummy images to scroll view
            var images = [String]()
            images.append(self.foodViewModel.food.imageUrl)
            images.append("header1")
            images.append("header2")
            
            let noOfImages = 3
            for i in 0..<noOfImages {
                let img = UIImageView(image: UIImage(named: images[i]))
                img.frame = CGRect(x: CGFloat(i) * self.scrollView.frame.width, y: 0, width: self.scrollView.frame.width, height: self.scrollView.frame.height)
                self.scrollView.addSubview(img)
            }
            self.scrollView.contentSize = CGSize(width: self.scrollView.frame.width * CGFloat(noOfImages), height: 1.0)
            self.scrollView.delegate = self
        }
        
        self.lblTitle.text = self.foodViewModel.food.name
        self.lblDetail.text = self.foodViewModel.food.description
        
        if self.foodViewModel.food.discountedPrice > 0.0 {
            let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: " PHP\(self.foodViewModel.food.price)")
                attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: attributeString.length))
            self.lblPrice.attributedText = attributeString
            self.lblDiscount.text = " PHP\(self.foodViewModel.food.discountedPrice) "
        }
        else {
            self.lblPrice.attributedText = NSMutableAttributedString(string: " PHP\(self.foodViewModel.food.price) ")
            self.lblDiscount.text = ""
        }
        
        // Setup CollectionView
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        // Add dummy foods
        self.moreFoods.append(["name": "Hot Corn and Cheese Dip", "image": "dessert-1"])
        self.moreFoods.append(["name": "Loaded Baked Potato Dip", "image": "dessert-2"])
        self.moreFoods.append(["name": "Pepperoni Bread", "image": "main-2"])
        self.moreFoods.append(["name": "Artichoke Spinach Dip", "image": "main-1"])
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
}

extension DetailTableViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moreFoods.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MoreFoodCollectionViewCell
        let food = moreFoods[indexPath.row]
        cell.imgView.image = UIImage(named: food["image"]!)
        cell.lblTitle.text = food["name"]
        // Configure the cell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 116.0, height: 128.0)
    }
}
