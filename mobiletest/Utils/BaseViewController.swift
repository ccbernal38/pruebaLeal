//
//  BaseViewController.swift
//  mobiletest
//
//  Created by Christian bernal on 7/07/20.
//  Copyright © 2020 Christian Bernal. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var loadingView : UIView?

    func getTableViewCell<T>(_ tableView: UITableView, type: T.Type) -> T where T: UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: String(describing: type)) as! T
    }
    func getDate(date: String, from:String, to:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = from
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        let dateFormat =  dateFormatter.date(from: date)
        dateFormatter.dateFormat = to
        return dateFormatter.string(from: dateFormat!)
    }
    
    func showLoading() {
        let onView = self.view
        let spinnerView = UIView.init(frame: onView!.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.8)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView!.addSubview(spinnerView)
        }
        
        loadingView = spinnerView
    }
    
    func removeLoading() {
        DispatchQueue.main.async {
            self.loadingView?.removeFromSuperview()
            self.loadingView = nil
        }
    }

}
