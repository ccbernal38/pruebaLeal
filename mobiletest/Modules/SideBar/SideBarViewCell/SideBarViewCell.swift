//
//  SideBarViewCell.swift
//  mobiletest
//
//  Created by Christian bernal on 7/07/20.
//  Copyright © 2020 Christian Bernal. All rights reserved.
//

import UIKit

class SideBarViewCell: UITableViewCell {

    @IBOutlet weak var notification_dot: UIImageView!
    @IBOutlet weak var lblId: UILabel!
    @IBOutlet weak var lblFecha: UILabel!
    var transaction: Transaction?
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
//        self.notification_dot.image = UIImage(named: "gray_dot")
    }
    
}
