//
//  DetailTransactionRouter.swift
//  mobiletest
//
//  Created by Christian bernal on 7/07/20.
//  Copyright (c) 2020 Christian Bernal. All rights reserved.
//  Modify By:  * Ari Munandar
//              * arimunandar.dev@gmail.com
//              * https://github.com/arimunandar

import UIKit

protocol IDetailTransactionRouter: class {
	// do someting...
}

class DetailTransactionRouter: IDetailTransactionRouter {	
	weak var view: DetailTransactionViewController?
	
	init(view: DetailTransactionViewController?) {
		self.view = view
	}
}
