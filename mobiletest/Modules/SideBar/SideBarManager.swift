//
//  SideBarManager.swift
//  mobiletest
//
//  Created by Christian bernal on 6/07/20.
//  Copyright (c) 2020 Christian Bernal. All rights reserved.
//  Modify By:  * Ari Munandar
//              * arimunandar.dev@gmail.com
//              * https://github.com/arimunandar

import Foundation
import Alamofire

protocol ISideBarManager: class {
    func getTransactions(callback: MainManagerCallback)
    func onSuccess(data: Data, callback:MainManagerCallback)
    
}

protocol MainManagerCallback {
    func onSuccess(transactions : [MainModel.Transaction])
    func onError(message : String)
}

class SideBarManager: ISideBarManager {
    
    func getTransactions(callback: MainManagerCallback) {
        if(NetworkReachabilityManager()!.isReachable){
            print("____getTransactions____")
            let url = ConfigurationHelper.getConfiguration(ConfigurationKey.baseURL) + Endpoint.transaction
            AF.request(url).validate().response { (responseData) in
                
                switch responseData.result{
                    case .success:
                        guard let data = responseData.data else{return}
                        self.onSuccess(data: data, callback: callback)
                    case .failure(let error):
                        print(error)
                }
            }
        }else{
            callback.onError(message:"No hay conexión a Internet")
        }
        
    }
    func onSuccess(data:Data, callback:MainManagerCallback) {
        do{
            let transactions = try JSONDecoder().decode([MainModel.Transaction].self, from: data)
            callback.onSuccess(transactions: transactions)
        } catch{
            print(error)
        }
    }
}
