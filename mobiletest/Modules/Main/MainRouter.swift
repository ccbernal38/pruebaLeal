//
//  MainRouter.swift
//  mobiletest
//
//  Created by Christian bernal on 6/07/20.
//  Copyright (c) 2020 Christian Bernal. All rights reserved.
//  Modify By:  * Ari Munandar
//              * arimunandar.dev@gmail.com
//              * https://github.com/arimunandar

import UIKit

protocol IMainRouter: class {
	// do someting...
}

class MainRouter: IMainRouter {	
	weak var view: MainViewController?
	
	init(view: MainViewController?) {
		self.view = view
	}
}
