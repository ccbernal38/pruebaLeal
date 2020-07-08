//
//  GeneralRoute.swift
//  mobiletest
//
//  Created by Christian bernal on 6/07/20.
//  Copyright (c) 2020 Christian Bernal. All rights reserved.
//  Modify By:  * Ari Munandar
//              * arimunandar.dev@gmail.com
//              * https://github.com/arimunandar

import Foundation
import UIKit
import SideMenu

enum GeneralRoute: IRouter {
    /*
     If you want passing with parameters
     you just add like this:
     
     case sample
     case sample(parameter: [String: Any])
     
     you can use: String, Int, [String: Any], etc..
    */
    case main
    case sidebar
    case detail(parameters:[String:Any])
}

extension GeneralRoute {
    var module: UIViewController? {
        switch self {
            case .main:
                return MainConfiguration.setup()
            case .sidebar:
                let viewController = SideBarConfiguration.setup()
                let menu = SideMenuNavigationController(rootViewController: viewController)
                menu.leftSide = true
                menu.presentationStyle = .viewSlideOutMenuIn
                menu.enableSwipeToDismissGesture = false
                menu.enableTapToDismissGesture = true
                return menu
            case.detail(let parameters):
                return DetailTransactionConfiguration.setup(parameters: parameters)
            default:
                return MainConfiguration.setup()
        }
        
        return nil
    }
}
