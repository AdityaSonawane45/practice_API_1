//
//  ViewController.swift
//  practice_API_1
//
//  Created by Mac on 29/02/24.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {

    @IBOutlet weak var productTableView: UITableView!
    var productArray : [Product] = []
    let productTableViewCellIdentifier = "productTableViewCell"
    var SecondViewControllerIdentifier : SecondViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        initialiseTableView()
        registerXIBWithTableView()
        
    }
    
    func initialiseTableView(){
        productTableView.dataSource = self
        productTableView.delegate = self
    }
    
    func registerXIBWithTableView(){
        let uiNib = UINib(nibName: productTableViewCellIdentifier, bundle: nil)
        productTableView.register(uiNib, forCellReuseIdentifier: productTableViewCellIdentifier)
    }
    
    func fetchData(){
        let postUrl = URL(string: "https://dummyjson.com/products/search?q=Laptop")
        
        var productUrlRequest = URLRequest(url: postUrl!)
        
        let productUrlSession = URLSession(configuration: .default)
        productUrlRequest.httpMethod = "GET"
        
        let productDataTask = productUrlSession.dataTask(with: productUrlRequest) {data, response, error in
            let productResponse = try! JSONSerialization.jsonObject(with: data!) as! [String : Any]
            let product = productResponse["products"] as! [[String : Any]]
            for eachData in product{
                let productId = eachData["id"] as! Int
                let productTitle = eachData["title"] as! String
                let productDescription = eachData["description"] as! String
                let productPrice = eachData["price"] as! Int
                let productDiscountPercentage = eachData["discountPercentage"] as! Double
                let productRating = eachData["rating"] as! Double
                let productStock = eachData["stock"] as! Int
                let productBrand = eachData["brand"] as! String
                let productCategory = eachData["category"] as! String
                let productThumbnail = eachData["thumbnail"] as! String
                
                let newProductObject = Product(id: productId, title: productTitle, description: productDescription, price: productPrice, discountPercentage: productDiscountPercentage, rating: productRating, stock: productStock, brand: productBrand, category: productCategory, thumbnail: productThumbnail)
                self.productArray.append(newProductObject)
                
            }
            DispatchQueue.main.async {
                self.productTableView.reloadData()
        }
        
     }
        productDataTask.resume()
   }

}

extension ViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        productArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ProductTableViewCell = self.productTableView.dequeueReusableCell(withIdentifier: productTableViewCellIdentifier) as! productTableViewCell
        
        ProductTableViewCell.idLabel.text = String(productArray[indexPath.row].id)
        ProductTableViewCell.titleLabel.text = productArray[indexPath.row].title
        ProductTableViewCell.descriptionLabel.text = productArray[indexPath.row].description
        ProductTableViewCell.priceLabel.text = String(productArray[indexPath.row].price)
        ProductTableViewCell.discountPercentageLabel.text = String(productArray[indexPath.row].discountPercentage)
        ProductTableViewCell.ratingLabel.text = String(productArray[indexPath.row].rating)
        ProductTableViewCell.stockLabel.text = String(productArray[indexPath.row].stock)
        ProductTableViewCell.brandLabel.text = productArray[indexPath.row].brand
        ProductTableViewCell.categoryLabel.text = productArray[indexPath.row].category
        ProductTableViewCell.productImage.sd_setImage(with: URL(string: productArray[indexPath.row].thumbnail))
        return ProductTableViewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        secondViewController.productDetailsContainer = productArray[indexPath.row]
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
}
