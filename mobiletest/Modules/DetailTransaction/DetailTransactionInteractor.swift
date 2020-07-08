//
//  DetailTransactionInteractor.swift
//  mobiletest
//
//  Created by Christian bernal on 7/07/20.
//  Copyright (c) 2020 Christian Bernal. All rights reserved.
//  Modify By:  * Ari Munandar
//              * arimunandar.dev@gmail.com
//              * https://github.com/arimunandar

import UIKit
import Alamofire

protocol IDetailTransactionInteractor: class {
	var parameters: [String: Any]? { get set }
    func getTransaction() -> Transaction
    func getDetailTransaction()
}

class DetailTransactionInteractor: IDetailTransactionInteractor, DetailTransactionManagerCallback {
       
    var presenter: IDetailTransactionPresenter?
    var manager: IDetailTransactionManager?
    var parameters: [String: Any]?

    init(presenter: IDetailTransactionPresenter, manager: IDetailTransactionManager) {
    	self.presenter = presenter
    	self.manager = manager
    }
    func getTransaction() -> Transaction {
        return self.parameters!["transaction"] as! Transaction
    }
    func getDetailTransaction(){
        let transaction = getTransaction()
        self.manager?.getDetailTransaction(transactionId: Int(transaction.id), callback: self)
    }
    func onSuccess(response: [String : Any]) {
        let serviceName = response["serviceName"] as! String
        if serviceName == "getDetailTransaction"{
            let transaction = getTransaction()
            self.manager?.getUser(userid: Int(transaction.userId), callback: self)
            let detail = response["response"] as! DetailTransactionModel.Detail
            self.presenter?.setDetailsData(detail: detail)
        }else if serviceName == "getUser"{
            let user = response["response"] as! DetailTransactionModel.User
            self.presenter?.setUserData(user: user)
        }
    }
    
    func onError(message: String, error: HTTPURLResponse?) {
        presenter!.showErrorMessage(message: message)
    }
}
