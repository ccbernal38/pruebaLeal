//
//  Constant.swift
//  mobiletest
//
//  Created by Christian bernal on 6/07/20.
//  Copyright © 2020 Christian Bernal. All rights reserved.
//

import UIKit

struct Endpoint {
    static let transaction = "/transactions"
    static let transaction_info = "/info"
    static let user = "/users"
}
class Alert {
 
    
    static func showAlert(title:String, message:String, viewcontroller: UIViewController, completion: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: .destructive, handler: completion))
        viewcontroller.present(alert, animated: true)
    }
}

extension UITableView{
    func getTableViewCell<T>(_ tableView: UITableView, type: T.Type) -> T where T: UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: String(describing: type)) as! T
    }
}
