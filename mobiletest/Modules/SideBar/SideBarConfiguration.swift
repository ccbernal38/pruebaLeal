//
//  SideBarConfiguration.swift
//  mobiletest
//
//  Created by Christian bernal on 6/07/20.
//  Copyright (c) 2020 Christian Bernal. All rights reserved.
//  Modify By:  * Ari Munandar
//              * arimunandar.dev@gmail.com
//              * https://github.com/arimunandar

import Foundation
import UIKit

class SideBarConfiguration {
    static func setup(parameters: [String: Any] = [:]) -> UIViewController {
        let controller = UIStoryboard.getViewController(storyId: "Main", to: SideBarViewController.self)
        let router = SideBarRouter(view: controller)
        let presenter = SideBarPresenter(view: controller)
        let manager = SideBarManager()
        let interactor = SideBarInteractor(presenter: presenter, manager: manager)
        controller.appDelegate = UIApplication.shared.delegate as! AppDelegate
        controller.managedContext = controller.appDelegate!.persistentContainer.viewContext

        interactor.appDelegate = controller.appDelegate!
        interactor.managedContext = controller.managedContext!
        controller.interactor = interactor
        controller.router = router
        interactor.parameters = parameters
        return controller
    }
}
