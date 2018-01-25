//
//  JGGPostServiceAddressVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 12/5/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit
import Toaster

class JGGPostServiceAddressVC: JGGPostAppointmentBaseTableVC {

    @IBOutlet weak var txtPlaceName: UITextField!
    @IBOutlet weak var txtUnits: UITextField!
    @IBOutlet weak var txtStreet: UITextField!
    @IBOutlet weak var txtPostcode: UITextField!
    @IBOutlet weak var btnDontShowFullAddress: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtPlaceName.delegate = self
        txtUnits.delegate = self
        txtStreet.delegate = self
        txtPostcode.delegate = self
        
        txtPlaceName.text = nil
        txtUnits.text = nil
        txtStreet.text = nil
        txtPostcode.text = nil

        if SHOW_TEMP_DATA {
            showTemporaryData()
        }

    }

    private func showTemporaryData() {
        txtPlaceName.text = "My home"
        txtUnits.text = "20"
        txtStreet.text = "wanchingru 200"
        txtPostcode.text = "118000"
    }

    override func updateData(_ sender: Any) {
        if let parentVC = parent as? JGGPostServiceStepRootVC {
            let addressModel = JGGAddressModel()
            addressModel.unit = txtUnits.text
            addressModel.floor = txtPlaceName.text
            addressModel.address = txtStreet.text
            addressModel.postalCode = txtPostcode.text
            if let btnDontShowFullAddress = btnDontShowFullAddress {
                addressModel.isDontShowFullAddress = btnDontShowFullAddress.isSelected
            }
            let creatingService = parentVC.creatingService
            creatingService?.address = addressModel
        }
    }
    
    @IBAction func onPressedDontShowMyFullAddress(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    override func onPressedNext(_ sender: UIButton) {
        if let unit = txtUnits.text, let street = txtStreet.text, let postalCode = txtPostcode.text {
            if unit.count > 0 && street.count > 0 && postalCode.count > 0 {
                super.onPressedNext(sender)
                if let parentVC = parent as? JGGPostServiceStepRootVC {
                    parentVC.gotoSummaryVC()
                }
                return
            }
        }
        Toast(text: LocalizedString("Please enter where do you need the service."), delay: 0, duration: 3).show()
    }
}

extension JGGPostServiceAddressVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtPlaceName {
            txtUnits.becomeFirstResponder()
        } else if textField ==  txtUnits {
            txtStreet.becomeFirstResponder()
        }
        else if textField == txtStreet {
            txtPostcode.becomeFirstResponder()
        }
        else if textField == txtPostcode {
            txtPostcode.resignFirstResponder()
        }
        return false
    }
}