//
//  JGGAlertViewController.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 11/7/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit
import SnapKit
import MZFormSheetPresentationController

public typealias JGGAlertButtonBlock = ((String?) -> Void)

class JGGAlertViewController: UIViewController {

    // MARK: - Class methods to show alert
    static func show(title: String?,
                     message: String?,
                     colorSchema: JGGColorSchema = .green,
                     cancelColorSchema: JGGColorSchema? = nil,
                     textFieldPlaceholder: String? = nil,
                     okButtonTitle: String = "OK",
                     okAction: JGGAlertButtonBlock? = nil,
                     cancelButtonTitle: String? = "Cancel",
                     cancelAction: JGGAlertButtonBlock? = nil)
    {
        let topVC = UIApplication.topViewController()

        let alertVC = JGGAlertViewController(nibName: "JGGAlertViewController", bundle: nil)
            alertVC.alertTitle = title
            alertVC.alertMessage = message
            alertVC.colorSchema = colorSchema
            alertVC.cancelColor = cancelColorSchema
            alertVC.textfieldPlaceholder = textFieldPlaceholder
            alertVC.okButtonTitle = okButtonTitle
            alertVC.okAction = okAction
            alertVC.cancelButtonTitle = cancelButtonTitle
            alertVC.cancelAction = cancelAction
            
        let mzformSheetVC = MZFormSheetPresentationViewController(contentViewController: alertVC)
            mzformSheetVC.contentViewControllerTransitionStyle = .bounce
            topVC?.present(mzformSheetVC, animated: true, completion: nil)
    }
    
    // MARK: - Properties
    var alertTitle: String?
    var alertMessage: String?
    var colorSchema: JGGColorSchema = .green
    var cancelColor: JGGColorSchema?
    var textfieldPlaceholder: String? = nil
    var okButtonTitle: String = "OK"
    var okAction: JGGAlertButtonBlock?
    var cancelButtonTitle: String?
    var cancelAction: JGGAlertButtonBlock?
    
    // MARK: UI Properties
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var viewReason: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnOK: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
    }

    private func initUI() {
        
        self.lblTitle.text = alertTitle
        self.lblMessage.text = alertMessage
        if let textfieldPlaceholder = textfieldPlaceholder {
            self.viewReason.isHidden = false
            self.textField.placeholder = textfieldPlaceholder
        } else {
            self.viewReason.isHidden = true
        }
        self.btnOK.setTitle(okButtonTitle, for: .normal)
        self.btnCancel.setTitle(cancelButtonTitle, for: .normal)
        
        switch colorSchema {
        case .green:
            btnOK.backgroundColor = UIColor.JGGGreen
            btnOK.setTitleColor(UIColor.JGGWhite, for: .normal)
            if cancelColor == nil {
                btnCancel.backgroundColor = UIColor.JGGGreen10Percent
                btnCancel.setTitleColor(UIColor.JGGGreen, for: .normal)
            }
            break
        case .cyan:
            btnOK.backgroundColor = UIColor.JGGCyan
            btnOK.setTitleColor(UIColor.JGGWhite, for: .normal)
            if cancelColor == nil {
                btnCancel.backgroundColor = UIColor.JGGCyan10Percent
                btnCancel.setTitleColor(UIColor.JGGCyan, for: .normal)
            }
            break
        case .red:
            btnOK.backgroundColor = UIColor.JGGRed
            btnOK.setTitleColor(UIColor.JGGWhite, for: .normal)
            if cancelColor == nil {
                btnCancel.backgroundColor = UIColor.JGGGreen10Percent
                btnCancel.setTitleColor(UIColor.JGGGreen, for: .normal)
            }
            break
        case .orange:
            btnOK.backgroundColor = UIColor.JGGOrange
            btnOK.setTitleColor(UIColor.JGGWhite, for: .normal)
            if cancelColor == nil {
                btnCancel.backgroundColor = UIColor.JGGOrange10Percent
                btnCancel.setTitleColor(UIColor.JGGOrange, for: .normal)
            }
            break
        case .purple:
            btnOK.backgroundColor = UIColor.JGGPurple
            btnOK.setTitleColor(UIColor.JGGWhite, for: .normal)
            if cancelColor == nil {
                btnCancel.backgroundColor = UIColor.JGGPurple10Percent
                btnCancel.setTitleColor(UIColor.JGGPurple, for: .normal)
            }
            break

        }
        
        if let cancelColor = cancelColor {
            switch cancelColor {
            case .green:
                btnCancel.backgroundColor = UIColor.JGGGreen10Percent
                btnCancel.setTitleColor(UIColor.JGGGreen, for: .normal)
                break
            case .cyan:
                btnCancel.backgroundColor = UIColor.JGGCyan10Percent
                btnCancel.setTitleColor(UIColor.JGGCyan, for: .normal)
                break
            case .red:
                btnCancel.backgroundColor = UIColor.JGGRed10Percecnt
                btnCancel.setTitleColor(UIColor.JGGRed, for: .normal)
                break
            case .orange:
                btnCancel.backgroundColor = UIColor.JGGOrange10Percent
                btnCancel.setTitleColor(UIColor.JGGOrange, for: .normal)
                break
            case .purple:
                btnCancel.backgroundColor = UIColor.JGGPurple10Percent
                btnCancel.setTitleColor(UIColor.JGGPurple, for: .normal)
                break
            }
        }
        
        if cancelButtonTitle == nil {
            btnCancel.removeConstraints(btnCancel.constraints)
            btnCancel.isHidden = true
            btnOK.removeConstraints(btnOK.constraints)
            btnOK.snp.makeConstraints({ (maker) in
                maker.left.top.right.bottom.equalToSuperview()
            })
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !viewReason.isHidden {
            textField.becomeFirstResponder()
        }
    }
    
    @IBAction func onPressedCancel(_ sender: Any) {
        self.dismiss(animated: true) {
            self.cancelAction?(self.textField.text)
        }
    }
    
    @IBAction func onPressedOK(_ sender: Any) {
        self.dismiss(animated: true) {
            self.okAction?(self.textField.text)
        }
    }
    
}

extension JGGAlertViewController: MZFormSheetPresentationContentSizing {
    
    func shouldUseContentViewFrame(for presentationController: MZFormSheetPresentationController!) -> Bool {
        return true
    }
    
    func contentViewFrame(for presentationController: MZFormSheetPresentationController!, currentFrame: CGRect) -> CGRect {
        let screenSize = UIScreen.main.bounds.size
        var titleHeight: CGFloat = 10
        if let alertTitle = alertTitle {
            titleHeight = alertTitle.height(withConstrainedWidth: screenSize.width - 90, font: lblTitle.font)
        }
        var messageHeight: CGFloat = 10
        if let alertMessage = alertMessage {
            messageHeight = alertMessage.height(withConstrainedWidth: screenSize.width - 80, font: lblMessage.font)
        }
        var textfieldHeight: CGFloat = 64
        if viewReason.isHidden {
            textfieldHeight = 0
        }
        let resultFrameSize = CGSize(width: screenSize.width - 30,
                                     height: 120 + titleHeight + messageHeight + textfieldHeight)
        var resultOrigin = CGPoint(x: currentFrame.origin.x,
                                   y: (screenSize.height - resultFrameSize.height) / 2)
        if !viewReason.isHidden {
            resultOrigin.y -= 100
        }
        return CGRect(origin: resultOrigin, size: resultFrameSize)
    }
    
}
