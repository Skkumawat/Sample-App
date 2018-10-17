//
//  Utility.swift
//  SampleApp
//
//  Created by Sharvan  Kumawat on 9/30/18.
//  Copyright © 2018 Sharvan  Kumawat. All rights reserved.
//


import Foundation
import UIKit
import SystemConfiguration

class Utility: NSObject {
    
    class func removeWhitespaceFromString(text: String) -> Bool {
        let trimmedString = text.trimmingCharacters(in: .whitespaces)
        if trimmedString.characters.count > 0 {
            return true
        }
        else{
            return false
        }
    }
    class func checkNetworkStatus() -> Bool
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        
        return (isReachable && !needsConnection)
    }
    
    class func isConnectedToNetwork(view: UIViewController) -> Bool{
        
        if self.checkNetworkStatus() == false{
            let alertController = UIAlertController(title: "", message: networkError, preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            view.present(alertController, animated: true, completion: nil)
            return false
        }
        return true
    }

    
    class func showAlert(title: String?, message: String?, view: UIViewController){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        
        view.present(alertController, animated: true, completion: nil)
    }
    func checkForNull(value : Any)->String {
        if value is NSNull {
            return ""
        } else {
            return value as! String
        }
    }
    
    func checkForNullInt(value : Any)->Int {
        if value is NSNull {
            return 0
        } else {
            return value as! Int
        }
    }
    
    func checkForNullBool(value : Any)->Bool {
        if value is NSNull {
            return false
        } else {
            return value as! Bool
        }
    }
    
    func checkForNullDouble(value : Any)->Any {
        if value is NSNull {
            return 0.0
        } else {
            return value
        }
    }
}
