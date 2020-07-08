//
//  SideBarInteractor.swift
//  mobiletest
//
//  Created by Christian bernal on 6/07/20.
//  Copyright (c) 2020 Christian Bernal. All rights reserved.
//  Modify By:  * Ari Munandar
//              * arimunandar.dev@gmail.com
//              * https://github.com/arimunandar

import UIKit
import CoreData

protocol ISideBarInteractor: class {
	var parameters: [String: Any]? { get set }
    func getTransactions()
    func saveTransactions(transactions:[MainModel.Transaction]) -> [Transaction]
}

class SideBarInteractor: ISideBarInteractor, MainManagerCallback {
    var appDelegate:AppDelegate?
    var managedContext:NSManagedObjectContext?
    var presenter: ISideBarPresenter?
    var manager: ISideBarManager?
    var parameters: [String: Any]?

    init(presenter: ISideBarPresenter, manager: ISideBarManager) {
    	self.presenter = presenter
    	self.manager = manager
    }
    func getTransactions() {
        let fetchRequest:NSFetchRequest<Transaction> = Transaction.fetchRequest()
        do {
            let results = try managedContext!.fetch(fetchRequest)
            if results.count > 0 {
                self.presenter?.reloadTableView(transactions: results as [Transaction])
            } else{
                manager?.getTransactions(callback: self)
            }

        } catch let error as NSError {
            print("No ha sido posible cargar \(error), \(error.userInfo)")
            manager?.getTransactions(callback: self)
        }
    }
    
    func onSuccess(transactions: [MainModel.Transaction]) {
        let transactionsCoreData = self.saveTransactions(transactions: transactions)
        self.presenter?.reloadTableView(transactions: transactionsCoreData)
    }
    func onError(message: String) {
        presenter!.showErrorMessage(message: message)
    }
    func saveTransactions(transactions: [MainModel.Transaction]) -> [Transaction]{
        var result = [Transaction]()
        
        for value in transactions {
            
            //branch
            let branch = Branch(context: managedContext!)
            branch.setValue(value.branch.id, forKey: "id")
            branch.setValue(value.branch.name, forKey: "name")
            
            //Commerce
            let commerce = Commerce(context: managedContext!)
            commerce.setValue(value.commerce.id, forKey: "id")
            commerce.setValue(value.commerce.name, forKey: "name")
            commerce.setValue(value.commerce.valueToPoints, forKey: "valueToPoints")
            
            for valueBranch in value.commerce.branches {
                let branchCommerce = Branch(context: managedContext!)
                branchCommerce.setValue(valueBranch.id, forKey: "id")
                branchCommerce.setValue(valueBranch.name, forKey: "name")
                commerce.addToBranches(branchCommerce)
            }
            
            //Transaction
            let transaction = Transaction(context: managedContext!)
            transaction.setValue(value.id, forKey: "id")
            transaction.setValue(value.userId, forKey: "userId")
            transaction.setValue(value.createdDate, forKey: "createdDate")
            transaction.setValue(commerce, forKey: "commerce")
            transaction.setValue(branch, forKey: "branch")
            

            do {
                try managedContext!.save()
                result.append(transaction)
            } catch let error as NSError  {
                print("No ha sido posible guardar \(error), \(error.userInfo)")
            }
        }
        return result
    }
    
}
