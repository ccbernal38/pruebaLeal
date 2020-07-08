//
//  DetailTransactionManager.swift
//  mobiletest
//
//  Created by Christian bernal on 7/07/20.
//  Copyright (c) 2020 Christian Bernal. All rights reserved.
//  Modify By:  * Ari Munandar
//              * arimunandar.dev@gmail.com
//              * https://github.com/arimunandar

import Foundation
import Alamofire

protocol IDetailTransactionManager: class {
	
    func getUser(userid:Int, callback: DetailTransactionManagerCallback)
    func getDetailTransaction(transactionId:Int, callback: DetailTransactionManagerCallback)
}

protocol DetailTransactionManagerCallback {
    func onSuccess(response : [String:Any])
    func onError(message : String, error:HTTPURLResponse?)
}

class DetailTransactionManager: IDetailTransactionManager {
    func getDetailTransaction(transactionId: Int, callback: DetailTransactionManagerCallback) {
        if(NetworkReachabilityManager()!.isReachable){
            print("____getDetailTransaction____")
            let url = ConfigurationHelper.getConfiguration(ConfigurationKey.baseURL) + Endpoint.transaction + "/\(transactionId)\(Endpoint.transaction_info)"
            AF.request(url).validate().response { (responseData) in
                switch responseData.result{
                    case .success:
                        do{
                            guard let data = responseData.data else{return}
                            let details = try JSONDecoder().decode(DetailTransactionModel.Detail.self, from: data)
                            let response : [String:Any] = ["serviceName":"getDetailTransaction",
                                                           "response":details]
                            callback.onSuccess(response: response)
                        } catch{
                            print(error)
                        }
                    case .failure(let error):
                        callback.onError(message:"Error en el sistema. Intente más tarde", error: responseData.response)
                }

            }
        }else{
            callback.onError(message:"Error en el sistema. Intente más tarde", error: nil)
        }
    }
    
    func getUser(userid: Int, callback: DetailTransactionManagerCallback) {
        if(NetworkReachabilityManager()!.isReachable){
            print("____getUser____")
            let url = ConfigurationHelper.getConfiguration(ConfigurationKey.baseURL) + "\(Endpoint.user)/\(userid)"
            AF.request(url).validate().response { (responseData) in
                switch responseData.result{
                    case .success:
                        do{
                            guard let data = responseData.data else{return}
                            let details = try JSONDecoder().decode(DetailTransactionModel.User.self, from: data)
                            let response : [String:Any] = ["serviceName":"getUser",
                                                           "response":details]
                            callback.onSuccess(response: response)
                        } catch{
                            print(error)
                        }
                    case .failure(let error):
                        callback.onError(message:"Error en el sistema. Intente más tarde",error: responseData.response)
                }
                
            }
            
        }else{
            callback.onError(message:"Error en el sistema. Intente más tarde", error: nil)
        }
    }
    
        
}
