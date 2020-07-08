//
//  SideBarPresenter.swift
//  mobiletest
//
//  Created by Christian bernal on 6/07/20.
//  Copyright (c) 2020 Christian Bernal. All rights reserved.
//  Modify By:  * Ari Munandar
//              * arimunandar.dev@gmail.com
//              * https://github.com/arimunandar

import UIKit

protocol ISideBarPresenter: class {
    func showErrorMessage(message:String)
    func reloadTableView(transactions:[Transaction])
}

class SideBarPresenter: ISideBarPresenter {
    func reloadTableView(transactions: [Transaction]) {
        let viewController = view as! SideBarViewController
        viewController.setTransactions(transactions)
        viewController.reloadTableView()
        viewController.removeLoading()
    }
    
	weak var view: ISideBarViewController?
	
	init(view: ISideBarViewController?) {
		self.view = view
	}
    func showErrorMessage(message: String) {
        Alert.showAlert(title: "Alerta", message: message, viewcontroller: self.view as! UIViewController, completion: {
            alert in
            let viewcontroller = self.view as! SideBarViewController
            viewcontroller.removeLoading()
        })
    }

}
