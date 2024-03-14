//
//  SecondViewController.swift
//  practice_API_1
//
//  Created by Mac on 04/03/24.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var ProductImage: UIImageView!
    @IBOutlet weak var ProductTitle: UILabel!
    @IBOutlet weak var ProductId: UILabel!
    @IBOutlet weak var ProductPrice: UILabel!
    @IBOutlet weak var ProductDescription: UILabel!
    @IBOutlet weak var ProductBrand: UILabel!
    @IBOutlet weak var ProductCategory: UILabel!
    @IBOutlet weak var ProductDiscountPercentage: UILabel!
    @IBOutlet weak var ProductRating: UILabel!
    @IBOutlet weak var ProductStock: UILabel!
    
    var productDetailsContainer : Product?
    let ThumbnailUrl = URL(string: "https://dummyjson.com/products/search?q=Laptop")
    override func viewDidLoad() {
        super.viewDidLoad()
        imageBinding()
        bindData()

    }
    func imageBinding(){
        if let Thumbnail = productDetailsContainer?.thumbnail,
           let ThumbnailUrl = URL(string: Thumbnail) {
            ProductImage.sd_setImage(with: ThumbnailUrl)
        }
    }
    
    func bindData(){
        self.ProductId.text = productDetailsContainer?.id.description.codingKey.stringValue
        self.ProductTitle.text = productDetailsContainer?.title.description.codingKey.stringValue
        self.ProductPrice.text = productDetailsContainer?.price.description.codingKey.stringValue
        self.ProductDescription.text = productDetailsContainer?.description.description.codingKey.stringValue
        self.ProductDiscountPercentage.text = productDetailsContainer?.discountPercentage.description.codingKey.stringValue
        self.ProductRating.text = productDetailsContainer?.rating.description.codingKey.stringValue
        self.ProductStock.text = productDetailsContainer?.stock.description.codingKey.stringValue
        self.ProductBrand.text = productDetailsContainer?.brand.description.codingKey.stringValue
        self.ProductCategory.text = productDetailsContainer?.category.description.codingKey.stringValue
    }
 

}
