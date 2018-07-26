//
//  ErrorController.swift
//  WeatherApp
//
//  Created by Luka Lovretić on 26/07/2018.
//  Copyright © 2018 Luka Lovretić. All rights reserved.
//

import UIKit

class ErrorController: UIAlertController {
    //MARK: postavljanje alerta
    class func alert(viewToPresent: UIViewController, title: String, message: String) -> Void
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "U redu", style: .default)
       
        
        alert.addAction(action)
        viewToPresent.present(alert, animated: true, completion:nil)
    }
}
