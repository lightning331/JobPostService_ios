//
//  JGGPostJobPriceVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 12/28/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGPostJobPriceVC: JGGPostAppointmentBaseTableVC {

    @IBOutlet weak var btnNoLimits: JGGYellowSelectingButton!
    @IBOutlet weak var btnFixedAmount: JGGYellowSelectingButton!
    @IBOutlet weak var btnRangeAmount: JGGYellowSelectingButton!

    @IBOutlet weak var viewNoLimitsDescription: UIView!
    @IBOutlet weak var viewFixedAmount: UIView!
    @IBOutlet weak var txtFixedAmount: UITextField!
    @IBOutlet weak var viewRangeMinAmount: UIView!
    @IBOutlet weak var txtRangeMinAmount: UITextField!
    @IBOutlet weak var viewRangeMaxAmount: UIView!
    @IBOutlet weak var txtRangeMaxAmount: UITextField!
    
    fileprivate var selectedPriceType: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnNoLimits.defaultColor = UIColor.JGGCyan
        btnFixedAmount.defaultColor = UIColor.JGGCyan
        btnRangeAmount.defaultColor = UIColor.JGGCyan
        
        viewNoLimitsDescription.isHidden = true
        viewFixedAmount.isHidden = true
        viewRangeMinAmount.isHidden = true
        viewRangeMaxAmount.isHidden = true

        btnNext.isHidden = false
    }
    
    @IBAction private func onPressedPriceType(_ sender: JGGYellowSelectingButton) {
        sender.select(!sender.selected())
        
        viewNoLimitsDescription.isHidden = true
        viewFixedAmount.isHidden = true
        viewRangeMinAmount.isHidden = true
        viewRangeMaxAmount.isHidden = true

        var index: Int = 0
        if sender.selected() {
            
            if sender == btnNoLimits {
                index = 1
                btnFixedAmount.isHidden = true
                btnFixedAmount.select(false)
                btnRangeAmount.isHidden = true
                btnRangeAmount.select(false)
                viewNoLimitsDescription.isHidden = false
            } else if sender == btnFixedAmount {
                index = 2
                btnNoLimits.isHidden = true
                btnNoLimits.select(false)
                btnRangeAmount.isHidden = true
                btnRangeAmount.select(false)
                viewFixedAmount.isHidden = false
            }
            else if sender == btnRangeAmount {
                index = 3
                btnNoLimits.isHidden = true
                btnNoLimits.select(false)
                btnFixedAmount.isHidden = true
                btnFixedAmount.select(false)
                viewRangeMinAmount.isHidden = false
                viewRangeMaxAmount.isHidden = false
            }
        } else {
            btnNoLimits.isHidden = false
            btnFixedAmount.isHidden = false
            btnRangeAmount.isHidden = false
            
        }
        selectedPriceType = index
//        self.tableView.reloadData()
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if selectedPriceType > 0 {
//            return 2
//        }
        return 2
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
