//
//  DownloadManager.swift
//  SampleApp
//
//  Created by Sharvan  Kumawat on 9/30/18.
//  Copyright © 2018 Sharvan  Kumawat. All rights reserved.
//


import UIKit

class DownloadManager: NSObject {
    
    /**
     Creates a clouser function for getting data from the server and set dynamic data of the product.
     
     - Parameter: completionHandler for send data to Viewcontroller when getting data.
     
     - Throws:
     
     - Returns: Array of product types
     */
    
    class func getProductsList(completionHandler: @escaping(_ result: [[String: Any]]) -> Void) {
        
        var productList = [[String: Any]]()
        
        //If you can get data from the server then use below method
        
      /*  let endpoint: String = Utility.APIURL + "q=\(q)&pmin=\(pmin)&pmax=\(pmax)&wholesale=\(wholesale)&official=\(official)&fshop=\(fshop)&start=\(pageNo)&rows=\(PageRow)"
        
        print("endpoint===\(endpoint)")
        guard let url = URL(string: endpoint) else {
            print("Error: cannot create URL")
            return
        }
        let urlRequest = URLRequest(url: url)
        
        // set up the session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        // make the request
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            // check for any errors
            guard error == nil else {
                print("error calling GET on products list")
                print(error.debugDescription)
                return
            }
            
            // make sure we got data
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            
            // parse the result as JSON
            do {
                guard let json = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: AnyObject] else {
                    print("error trying to convert data to JSON")
                    return
                }
                
                var finalProducts = [ProductDetail]()
                if let products = json["data"] as? [[String: AnyObject]] {
                    
                    for product in products {
                        
                        let p = ProductDetail()
                        p.name = product["name"] as? String ?? ""
                        p.imageUrl = product["image_uri"] as? String ?? ""
                        p.price = product["price"] as? String ?? ""
                        finalProducts.append(p)
                    }
                }
                
                completion(finalProducts)
                
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
        }
        
        task.resume()
        */
            do {
                var products = [Product]()
                
                // For comics category type
                for i in 0..<totalRecords {
                    let model = Product()
                    if (i+1)%2 == 0 {
                        model.name = "Outlook Business"
                        model.imageName = "sec10"
                    }
                    else{
                        model.name = "Business India"
                        model.imageName = "sec11"
                    }
                    products.append(model)
                }
                productList.append(["type": productCategories[0], "product": products])
                products.removeAll()
                
                
                // For education category type
                
                for i in 0..<totalRecords {
                    let model = Product()
                    if (i+1)%2 == 0 {
                        model.name = "Chhota Bheem"
                        model.imageName = "sec20"
                    }
                    else{
                        model.name = "Krishna Series"
                        model.imageName = "sec21"
                    }
                    products.append(model)
                }
                productList.append(["type": productCategories[1], "product": products])
                products.removeAll()
                
                // For sports category type
                
                for i in 0..<totalRecords {
                    let model = Product()
                    if (i+1)%2 == 0 {
                        model.name = "1010 Riddles"
                        model.imageName = "sec30"
                    }
                    else{
                        model.name = "Captain Cool"
                        model.imageName = "sec31"
                    }
                    products.append(model)
                }
                productList.append(["type": productCategories[2], "product": products])
                
                //Call completionHandler after getting data form server
                completionHandler(productList)
                
                
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
    }
}
extension UIImageView {
    
    /**
     Creates a function for download the image from the server one by one using the URLSession request
     
     - Parameter: URL string of the Image
     
     - Throws: Getting error when url is not exist or image will not found
     
     - Returns: Image object
     */
    
    public func imageFromServerURL(urlString: String) {
        
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
            
        }).resume()
    }}

