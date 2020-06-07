//
//  BillViewController.swift
//  BillDay
//
//  Created by Jaime Tejeiro on 04/06/2020.
//  Copyright © 2020 Jtejeiro. All rights reserved.
//

import UIKit
import Foundation



class BillViewController: BaseViewController {
    
    
    // MARK: - Properties
    var presenter: BillPresenter?
    
    // MARK: - Outlets
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var constraintHeightTableView: NSLayoutConstraint!
    
    @IBOutlet weak var identifierLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var feeLabel: UILabel!
    @IBOutlet weak var feeNumberLabel: UILabel!
    @IBOutlet weak var amountNumberLabel: UILabel!
    @IBOutlet weak var totalNumberLabel: UILabel!
    @IBOutlet weak var typeAmountLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    // MARK: Private
    private var viewModel:BillViewModel!
    
    
    
    //MARK: - View Life Cycle Methods.
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.presenter?.viewDidLoad()
        setupInit()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter?.viewWillAppear()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.presenter?.viewDidAppear()
    }
    
    
    // MARK: IBActions
    
}

// MARK: - BillViewController
extension BillViewController: BillView {
    
    func showBill(billVM: BillViewModel) {
        self.viewModel = billVM
        configView()
    }
    
    func showAlertError(title: String, message: String) {

    }
    
    
    
}
// MARK: - Private methods
private extension BillViewController {
    
    // MARK: - Setup
    func setupInit() {
         self.navigationItem.title = "BillDay"
    }
    
    func configView() {
        configHeaderView()
        configTableView()
        refreshTableView()
    }
    
    func configHeaderView() {
        self.identifierLabel.text = String(viewModel.firstBill.id)
        self.descriptionLabel.text = viewModel.firstBill.billDescription
        if viewModel.firstBill.fee == nil || viewModel.firstBill.fee == 00 {
            feeLabel.alpha = 0.0
            feeNumberLabel.alpha = 0.0
        }else{
            feeLabel.alpha = 1.0
            feeNumberLabel.alpha = 1.0
            feeNumberLabel.text = viewModel.firstBill.getfeeString()
        }
        amountNumberLabel.text = viewModel.firstBill.getAmountString()
        totalNumberLabel.text = viewModel.firstBill.getTotalString()
        changeColorTypeAmount(type: viewModel.firstBill.getTypeAmount() )
        dateLabel.text = viewModel.firstBill.getDateString()
    }
    
    func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: BillTableViewCell.identifier , bundle: nil), forCellReuseIdentifier: BillTableViewCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        configHeaderTableView()
    }
    
    func configHeaderTableView(){
        tableView.register(UINib(nibName: HeaderBillTableViewCell.identifier, bundle: nil), forHeaderFooterViewReuseIdentifier: HeaderBillTableViewCell.identifier)
        tableView.sectionHeaderHeight = 44.0
    }
    
    func refreshTableView(){
        self.tableView.reloadData()
        self.tableView.layoutIfNeeded()
        self.constraintHeightTableView.constant = self.tableView.contentSize.height
        
        //Update with delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            self?.constraintHeightTableView.constant = self?.tableView.contentSize.height ?? 0
        }
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

extension BillViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return  viewModel.otherBillArray.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard let cell = Bundle.main.loadNibNamed(HeaderBillTableViewCell.identifier, owner: self, options: nil)?.first as? HeaderBillTableViewCell else {
            return HeaderBillTableViewCell()}
        
        if !viewModel.billSorted.isEmpty {
            let dateString = viewModel.otherBillArray[section].getDateString()
            cell.setupCell(dateString: dateString)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BillTableViewCell.identifier, for: indexPath) as? BillTableViewCell else{
            return BillTableViewCell()
        }
        if !viewModel.billSorted.isEmpty {
            cell.setupCell(element: viewModel.otherBillArray[indexPath.section])
        }
        return cell
    }
    
}
