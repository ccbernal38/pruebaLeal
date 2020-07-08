//
//  SideBarViewController.swift
//  mobiletest
//
//  Created by Christian bernal on 6/07/20.
//  Copyright (c) 2020 Christian Bernal. All rights reserved.
//  Modify By:  * Ari Munandar
//              * arimunandar.dev@gmail.com
//              * https://github.com/arimunandar

import UIKit
import CoreData

protocol ISideBarViewController: class {
	var router: ISideBarRouter? { get set }
    func getTransactions()
    func setTransactions(_ value: [Transaction])
    func reloadTableView()
    func getTableViewCell<T>(_ tableView: UITableView, type: T.Type) -> T where T: UITableViewCell
    func removeAll()
}

class SideBarViewController: BaseViewController {
	var interactor: ISideBarInteractor?
	var router: ISideBarRouter?
    var transactionsCoreData = [NSManagedObject]()
    var transactions:[Transaction] = []
    var appDelegate:AppDelegate?
    var managedContext:NSManagedObjectContext?

    @IBOutlet weak var tableView: UITableView!
    
	override func viewDidLoad() {
        super.viewDidLoad()
        
        if transactions.count == 0 {
            self.showLoading()
            self.getTransactions()
        }
    }
    @IBAction func btnRemoveAllPressed(_ sender: Any) {
        self.removeAll()
    }
    @IBAction func btnReloadPressed(_ sender: Any) {
        self.removeAll()
        self.showLoading()
        self.getTransactions()
    }
}

extension SideBarViewController: ISideBarViewController {
    func removeAll() {
        let fetchRequest:NSFetchRequest<Transaction> = Transaction.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
        do
        {
            try managedContext!.execute(deleteRequest)
        } catch let error as NSError {
            print(error)
        }
        self.transactions.removeAll()
        UIView.transition(with: tableView,
                          duration: 0.5,
                          options: .transitionFlipFromLeft,
                          animations:
            { () -> Void in
                self.tableView.reloadData()
        },
                          completion: nil);
        
    }
    
    
    
    func reloadTableView() {
        self.tableView.reloadData()
    }
    
    
    func setTransactions(_ value: [Transaction]) {
        self.transactions = value
    }
    
    func getTransactions() {
        guard let iteractor = interactor else{return}
        iteractor.getTransactions()
    }
}

extension SideBarViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.getTableViewCell(self.tableView, type: SideBarViewCell.self)
        switch indexPath.section {
            case 0:
                cell.notification_dot.isHidden = indexPath.row >= 20;
                cell.transaction = self.transactions[indexPath.row]
                if (cell.transaction?.isRead)! {
                    cell.notification_dot.image = UIImage(named: "gray_dot")
                }
                break
            default:
                break
        }
        cell.lblId.text = "Transacción #\(self.transactions[indexPath.row].id)"
        cell.lblFecha.text = self.getDate(date: self.transactions[indexPath.row].createdDate!, from: "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ", to: "MM-dd-yyyy HH:mm:ss")
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
            case 0:
                let cell = tableView.cellForRow(at: indexPath) as! SideBarViewCell
                cell.transaction?.isRead = true
                self.saveContext()
                cell.notification_dot.image = UIImage(named: "gray_dot")
                router?.navigateToDetailTransaction(transaction: cell.transaction!)
            default:
            break
        }
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{

            let value = self.transactions[indexPath.row] as! NSManagedObject
            self.managedContext?.delete(value)
            self.transactions.remove(at: indexPath.row)
            
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            self.saveContext()
        }
    }
    func saveContext(){
        do {
            try self.managedContext?.save()
        } catch {
            print(error)
        }
    }
}

extension SideBarViewController {
	// do someting...
}
