//
//  AppUtils.swift
//  Weather
//
//  Created by Sousuke Tanaka on 11/1/17.
//  Copyright © 2017 Sousuke Tanaka. All rights reserved.
//

import UIKit

class AppUtils: NSObject {
    
    class func presentAlert(parent controller: UIViewController, title: String?, message: String?, handler:  ((UIAlertAction) -> Swift.Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: handler))
        controller.present(alert, animated: true, completion: nil)
    }
    
}
