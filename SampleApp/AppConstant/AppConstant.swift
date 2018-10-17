//
//  AppConstant.swift
//  SampleApp
//
//  Created by Sharvan  Kumawat on 9/30/18.
//  Copyright © 2018 Sharvan  Kumawat. All rights reserved.
//

import Foundation
import UIKit
import SystemConfiguration

let networkError  = "Internet connection not available!"

var kOBJ_INDEX = "kOBJ_INDEX"

let productCategories = ["Comics", "Education", "Sports"]

enum APIMETHOD: String {
    
    case productList                  = "productList"
    case productDetails                  = "productDetails"
    
}

var DeviceToken = ""
let deviceType = "ios"

let totalRecords = 10


let userDefaults = UserDefaults.standard

let obj_appDelegate = (UIApplication.shared.delegate! as! AppDelegate)

var mainUrl: String {
    #if DEBUG
        return "http://demourl.com"
    #else
        return "http://liveurl.com"
    #endif
}


extension APIMETHOD {
    static var baseURL: String {
        return "\(mainUrl)api/mobile/"
    }
    var imagePath: String {
        return "\(APIMETHOD.baseURL)assets/uploads/users/"
    }
    var apiPath: String {
        return "\(APIMETHOD.baseURL)api/mobile/"
    }
    var methodPath: String {
        return self.rawValue
    }
}
