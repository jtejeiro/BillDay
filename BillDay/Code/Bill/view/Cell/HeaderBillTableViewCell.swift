//
//  HeaderBillTableViewCell.swift
//  BillDay
//
//  Created by Jaime Tejeiro on 04/06/2020.
//  Copyright © 2020 Jtejeiro. All rights reserved.
//

import UIKit

class HeaderBillTableViewCell: UITableViewCell {
    
    static let identifier = "HeaderBillTableViewCell"
    
    @IBOutlet weak var dateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(dateString:String){
        self.dateLabel.text = dateString
    }
}
