//
//  MainModel.swift
//  mobiletest
//
//  Created by Christian bernal on 6/07/20.
//  Copyright (c) 2020 Christian Bernal. All rights reserved.
//  Modify By:  * Ari Munandar
//              * arimunandar.dev@gmail.com
//              * https://github.com/arimunandar

import UIKit

struct MainModel {	
    struct Transaction : Codable{
        var id : Int
        var userId : Int
        var createdDate : String
        var commerce : Commerce
        var branch : Branch
    }

    struct Commerce :Codable {
        var id : Int
        var name : String
        var valueToPoints : Int
        var branches : [Branch]
    }
    struct Branch :Codable {
        var id : Int
        var name : String
    }
}
