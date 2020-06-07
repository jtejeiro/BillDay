//
//  BillTableViewCell.swift
//  BillDay
//
//  Created by Jaime Tejeiro on 04/06/2020.
//  Copyright © 2020 Jtejeiro. All rights reserved.
//

import UIKit

class BillTableViewCell: UITableViewCell {
    
    static let identifier = "BillTableViewCell"
    
    @IBOutlet weak var identifierLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var feeLabel: UILabel!
    @IBOutlet weak var feeNumberLabel: UILabel!
    @IBOutlet weak var amountNumberLabel: UILabel!
    @IBOutlet weak var totalNumberLabel: UILabel!
    @IBOutlet weak var typeAmountLabel: UILabel!
    



    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(element:BillResponseElement){
        self.identifierLabel.text = String(element.id)
        self.descriptionLabel.text = element.billDescription
        
        if element.fee == nil || element.fee == 00 {
            feeLabel.alpha = 0.0
            feeNumberLabel.alpha = 0.0
        }else{
            feeLabel.alpha = 1.0
            feeNumberLabel.alpha = 1.0
            feeNumberLabel.text = element.getfeeString()
        }
        amountNumberLabel.text = element.getAmountString()
        totalNumberLabel.text = element.getTotalString()
        changeColorTypeAmount(type: element.getTypeAmount() )
    }
    
    func changeColorTypeAmount(type:TypeAmountBill){
        switch type {
        case .Positive:
            typeAmountLabel.text = "+"
            typeAmountLabel.textColor = .green
            amountNumberLabel.textColor = .green
            
        case .neutral:
            typeAmountLabel.isHidden = true
            
        case .Negative:
            typeAmountLabel.text = "-"
            typeAmountLabel.textColor = .red
            amountNumberLabel.textColor = .red
        }
    }
}
