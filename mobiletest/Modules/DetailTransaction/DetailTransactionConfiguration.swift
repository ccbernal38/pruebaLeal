//
//  DetailTransactionConfiguration.swift
//  mobiletest
//
//  Created by Christian bernal on 7/07/20.
//  Copyright (c) 2020 Christian Bernal. All rights reserved.
//  Modify By:  * Ari Munandar
//              * arimunandar.dev@gmail.com
//              * https://github.com/arimunandar

import Foundation
import UIKit

class DetailTransactionConfiguration {
    static func setup(parameters: [String: Any] = [:]) -> UIViewController {
        let controller = UIStoryboard.getViewController(storyId: "Main", to: DetailTransactionViewController.self)
        let router = DetailTransactionRouter(view: controller)
        let presenter = DetailTransactionPresenter(view: controller)
        let manager = DetailTransactionManager()
        let interactor = DetailTransactionInteractor(presenter: presenter, manager: manager)
        
        controller.interactor = interactor
        controller.router = router
        interactor.parameters = parameters
        return controller
    }
}
