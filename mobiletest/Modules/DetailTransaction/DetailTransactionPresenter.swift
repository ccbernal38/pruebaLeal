//
//  DetailTransactionPresenter.swift
//  mobiletest
//
//  Created by Christian bernal on 7/07/20.
//  Copyright (c) 2020 Christian Bernal. All rights reserved.
//  Modify By:  * Ari Munandar
//              * arimunandar.dev@gmail.com
//              * https://github.com/arimunandar

import UIKit

protocol IDetailTransactionPresenter: class {
    func showErrorMessage(message: String)
    func setDetailsData(detail: DetailTransactionModel.Detail)
    func setUserData(user: DetailTransactionModel.User)
}

class DetailTransactionPresenter: IDetailTransactionPresenter {
   
    
	weak var view: IDetailTransactionViewController?
	
	init(view: IDetailTransactionViewController?) {
		self.view = view
	}
    
    func showErrorMessage(message: String) {
        Alert.showAlert(title: "Alerta", message: message, viewcontroller: self.view as! UIViewController, completion: {
            alert in
            let viewController =  self.view as! DetailTransactionViewController
            viewController.removeLoading()
            viewController.navigationController?.popViewController(animated: true)

        })

        
    }
    
    func setDetailsData(detail: DetailTransactionModel.Detail) {
        let viewController =  view as! DetailTransactionViewController
        viewController.lblValueTransaction.text = "Valor: \(detail.value)"
        viewController.lblPointsTransaction.text = "Puntos: \(detail.points)"
    }
    
    func setUserData(user: DetailTransactionModel.User) {
        let viewController =  view as! DetailTransactionViewController
        viewController.lblName.text = "\(user.name)"
        viewController.lblBirthdate.text = viewController.getDate(date:user.birthday,from:"yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ", to: "dd/MM/yyyy")
        do {
            let url = URL(string: user.photo)
            let data = try Data(contentsOf: url!)
            let imageView = viewController.imageViewUser
            imageView!.image = UIImage(data: data)
            imageView?.layer.borderColor = UIColor.yellow.cgColor
            imageView?.layer.borderWidth = 3.0
            imageView?.layer.cornerRadius = (imageView?.bounds.width)! / 2
            imageView?.layer.masksToBounds = true
        }
        catch{
            print(error)
        }
        viewController.removeLoading()
    }
}
