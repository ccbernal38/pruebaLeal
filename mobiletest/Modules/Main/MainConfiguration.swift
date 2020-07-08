//
//  MainConfiguration.swift
//  mobiletest
//
//  Created by Christian bernal on 6/07/20.
//  Copyright (c) 2020 Christian Bernal. All rights reserved.
//  Modify By:  * Ari Munandar
//              * arimunandar.dev@gmail.com
//              * https://github.com/arimunandar

import Foundation
import UIKit

class MainConfiguration {
    static func setup(parameters: [String: Any] = [:]) -> UIViewController {
        let controller = UIStoryboard.getViewController(storyId: "Main", to: MainViewController.self)
        let router = MainRouter(view: controller)
        let presenter = MainPresenter(view: controller)
        let manager = MainManager()
        let interactor = MainInteractor(presenter: presenter, manager: manager)
        
        controller.interactor = interactor
        controller.router = router
        interactor.parameters = parameters
        return controller
    }
}
