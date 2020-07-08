//
//  SideBarRouter.swift
//  mobiletest
//
//  Created by Christian bernal on 6/07/20.
//  Copyright (c) 2020 Christian Bernal. All rights reserved.
//  Modify By:  * Ari Munandar
//              * arimunandar.dev@gmail.com
//              * https://github.com/arimunandar

import UIKit

protocol ISideBarRouter: class {
    func navigateToDetailTransaction(transaction: Transaction)
}

class SideBarRouter: ISideBarRouter {
    func navigateToDetailTransaction(transaction: Transaction) {
        let parameters = ["transaction":transaction]
        self.view?.navigate(module: GeneralRoute.detail(parameters: parameters))
    }
    
	weak var view: SideBarViewController?
	
	init(view: SideBarViewController?) {
		self.view = view
	}
}
