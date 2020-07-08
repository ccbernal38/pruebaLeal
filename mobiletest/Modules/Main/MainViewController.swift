//
//  MainViewController.swift
//  mobiletest
//
//  Created by Christian bernal on 6/07/20.
//  Copyright (c) 2020 Christian Bernal. All rights reserved.
//  Modify By:  * Ari Munandar
//              * arimunandar.dev@gmail.com
//              * https://github.com/arimunandar

import UIKit
import SideMenu

protocol IMainViewController: class {
	var router: IMainRouter? { get set }
}

class MainViewController: UIViewController {
	var interactor: IMainInteractor?
	var router: IMainRouter?
    @IBOutlet weak var btnMenu: UIButton!
    
	override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        self.navigate(type: .present, module: GeneralRoute.sidebar)
    }
    @IBAction func btnMenuPressed(_ sender: Any) {
        self.navigate(type: .present, module: GeneralRoute.sidebar)
    }
}

extension MainViewController: IMainViewController {
    
}

extension MainViewController {
	// do someting...
}

extension MainViewController {
	// do someting...
}
