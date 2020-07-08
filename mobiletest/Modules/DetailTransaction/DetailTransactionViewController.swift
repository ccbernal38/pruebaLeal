//
//  DetailTransactionViewController.swift
//  mobiletest
//
//  Created by Christian bernal on 7/07/20.
//  Copyright (c) 2020 Christian Bernal. All rights reserved.
//  Modify By:  * Ari Munandar
//              * arimunandar.dev@gmail.com
//              * https://github.com/arimunandar

import UIKit

protocol IDetailTransactionViewController: class {
	var router: IDetailTransactionRouter? { get set }
    
}

class DetailTransactionViewController: BaseViewController {
	var interactor: IDetailTransactionInteractor?
	var router: IDetailTransactionRouter?
    
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var imageViewUser: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblBirthdate: UILabel!
    
    @IBOutlet weak var lblTransactionId: UILabel!
    @IBOutlet weak var lblValueTransaction: UILabel!
    @IBOutlet weak var lblPointsTransaction: UILabel!
    
    @IBOutlet weak var lblCommerce: UILabel!
    @IBOutlet weak var lblBranch: UILabel!
    @IBOutlet weak var lblValueToPoints: UILabel!
    
    @IBOutlet weak var tableViewBranch: UITableView!
    
    var transaction : Transaction?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.showLoading()
        self.transaction = (interactor?.getTransaction())
        self.interactor?.getDetailTransaction()
        if let value = self.transaction {
            lblTransactionId.text = "Transaccion id: \(value.id)"
            
            lblCommerce.text = "Comercio: \(value.commerce!.name ?? "")"
            lblBranch.text = "Sucursal: \(value.branch!.name ?? "")"
            lblValueToPoints.text = "Valor a puntos: \(value.commerce!.valueToPoints)"
        }
        
        
    }
    
    @IBAction func btnClosePressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension DetailTransactionViewController: IDetailTransactionViewController {

}

extension DetailTransactionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let value = transaction {
            return value.commerce!.branches!.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.getTableViewCell(self.tableViewBranch, type: DetailTransactionViewCell.self)
        let branches = self.transaction!.commerce!.branches?.allObjects as! [Branch]
        let value = branches[indexPath.row]
        cell.lblName.text = value.name
        return cell
    }
}

extension DetailTransactionViewController {

}
