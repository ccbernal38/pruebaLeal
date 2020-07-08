//
//  MainInteractor.swift
//  mobiletest
//
//  Created by Christian bernal on 6/07/20.
//  Copyright (c) 2020 Christian Bernal. All rights reserved.
//  Modify By:  * Ari Munandar
//              * arimunandar.dev@gmail.com
//              * https://github.com/arimunandar

import UIKit

protocol IMainInteractor: class {
	var parameters: [String: Any]? { get set }
}

class MainInteractor: IMainInteractor {
    var presenter: IMainPresenter?
    var manager: IMainManager?
    var parameters: [String: Any]?

    init(presenter: IMainPresenter, manager: IMainManager) {
    	self.presenter = presenter
    	self.manager = manager
    }
    
   
}
