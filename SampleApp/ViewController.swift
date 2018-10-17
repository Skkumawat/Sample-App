//
//  ViewController.swift
//  SampleApp
//
//  Created by Sharvan  Kumawat on 9/30/18.
//  Copyright © 2018 Sharvan  Kumawat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var productList = [[String : Any]]()
    
    @IBOutlet weak var productTblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()

        loadProductData()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    /**
     Creates a function for the table view configuration.
     
     - Parameter:
     
     - Throws:
     
     - Returns:
     */
    
    func configureTableView(){
        
        self.productTblView.separatorStyle = .none
        self.productTblView.separatorInset = UIEdgeInsets.zero
        self.productTblView.rowHeight = UITableViewAutomaticDimension
        
        self.productTblView.register(UINib(nibName: "CustomFooterCell", bundle: nil), forCellReuseIdentifier: "CustomFooterCell")
        
    }
    /**
     Creates a function for load dynamic data store in a varialbe and display on the screen.
     
     - Parameter:
     
     - Throws: nil value when we are not getting any data from the server
     
     - Returns: Array of the product list
     */
    func loadProductData(){
        if Utility.isConnectedToNetwork(view: self)
        {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            DownloadManager.getProductsList(completionHandler: { productData in
                
                self.productList = productData
                
                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    self.productTblView.reloadData()
                }
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
// MARK: - UITableViewDataSource
extension ViewController : UITableViewDataSource  {
    func numberOfSections(in tableView: UITableView) -> Int {
        return productList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let productListCell = tableView.dequeueReusableCell(withIdentifier:"ProductListCell", for: indexPath) as! ProductListCell
      
        productListCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.section)
        
        return productListCell
    }
    
    
}

// MARK: - UITableViewDelegate
extension ViewController : UITableViewDelegate  {
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let  footerCell = tableView.dequeueReusableCell(withIdentifier: "CustomFooterCell") as! CustomFooterCell
        footerCell.backgroundColor = UIColor.clear
        
        let productModel = productList[section]
        
        let type = productModel["type"] as! String
        
        footerCell.lblProductType.text = "\(type) >"
        
        footerCell.btnViewAll.addTarget(self, action: #selector(self.bntViewAllPresses(sender:)), for: .touchUpInside)
        
        objc_setAssociatedObject(footerCell.btnViewAll, &kOBJ_INDEX, section, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
        return footerCell
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 25
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let productModel = productList[collectionView.tag]
        let products = productModel["product"] as! [Product]
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        
        let productModel = productList[indexPath.section]
        let products = productModel["product"] as! [Product]
        let model = products[indexPath.row]
        
        cell.productName.text = model.name
        cell.productImage.image = UIImage(named: model.imageName!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
    }
}

extension ViewController {
    
    /**
     Creates a function when pressed all view button and get all respestive data of the product types
     
     - Parameter: sender
     
     - Throws:
     
     - Returns: Array of product types
     */
    
    @objc func bntViewAllPresses(sender: UIButton){
        let section = objc_getAssociatedObject(sender, &kOBJ_INDEX) as! Int
        let product = productList[section]
        let type = product["type"] as! String
        let model = product["product"] as! [Product]
        print("type==\(type)\n  model==\(model)")
        
        
    }
}
