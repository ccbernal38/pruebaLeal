//
//  DetailTransactionModel.swift
//  mobiletest
//
//  Created by Christian bernal on 7/07/20.
//  Copyright (c) 2020 Christian Bernal. All rights reserved.
//  Modify By:  * Ari Munandar
//              * arimunandar.dev@gmail.com
//              * https://github.com/arimunandar

import UIKit

struct DetailTransactionModel {	
    struct User : Codable {
		
        var id : Int
        var createdDate : String
        var name : String
        var birthday : String
        var photo : String
	}

    struct Detail : Codable {
        var transactionId : Int
        var value : Int
        var points : Int
    }
}
