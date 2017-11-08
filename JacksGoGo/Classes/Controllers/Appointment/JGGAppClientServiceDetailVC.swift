//
//  JGGAppClientServiceDetailVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 11/3/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit
import SnapKit

class JGGAppClientServiceDetailVC: JGGAppointmentsTableVC {
    
    var selectedAppointment: JGGAppointmentBaseModel?
    
    fileprivate var jobDetailHeaderView: JGGDetailInfoHeaderView?
    
    fileprivate let SECTION_PROVIDER: Int = 0
    fileprivate let SECTION_JOB_DETAIL: Int = 1
    
    fileprivate var isExandedJobDetail = false
    

    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTableView()
    }
    
    private func initTableView() {
        
        let headerView = UINib(nibName: "JGGNextStepTitleView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? JGGNextStepTitleView
        headerView?.title = LocalizedString("Wating for service provider...")
        self.tableView.tableHeaderView = headerView
        
        func registerHeaderFooterView(nibName: String) {
            self.tableView.register(UINib(nibName: nibName, bundle: nil), forHeaderFooterViewReuseIdentifier: nibName)
        }
        
        func registerCell(nibName: String) {
            self.tableView.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
        }
        
        registerHeaderFooterView(nibName: "JGGSectionTitleView")
        registerHeaderFooterView(nibName: "JGGDetailInfoHeaderView")
        registerHeaderFooterView(nibName: "JGGDetailInfoFooterView")
        
        registerCell(nibName: "JGGUserAvatarNameRateCell")
        registerCell(nibName: "JGGDetailInfoDescriptionCell")
        registerCell(nibName: "JGGDetailInfoAccessoryButtonCell")
        registerCell(nibName: "JGGDetailInfoCenterAlignCell")
        registerCell(nibName: "JGGImageCarouselCell")
        registerCell(nibName: "JGGBorderButtonCell")
        
        if let appointment = self.selectedAppointment {
            if appointment.type == .jobs {
                
                headerView?.viewLeftGreenBar.backgroundColor = UIColor.JGGCyan
                headerView?.imgviewIcon.image = UIImage(named: "icon_provider")
                headerView?.lblTitle.text = "You've invited to a job!"
                
                let tableFooterView = UIView(frame: CGRect(origin: CGPoint.zero,
                                                           size: CGSize(width: self.view.bounds.width,
                                                                        height: 50)))
                let btnRejectJob = UIButton(type: .custom)
                btnRejectJob.backgroundColor = UIColor.JGGCyan10Percent
                btnRejectJob.titleLabel?.font = UIFont.JGGButton
                btnRejectJob.setTitle(LocalizedString("Reject Job"), for: .normal)
                btnRejectJob.setTitleColor(UIColor.JGGCyan, for: .normal)
                btnRejectJob.addTarget(self, action: #selector(onPressedRejectJob(_:)), for: .touchUpInside)
                tableFooterView.addSubview(btnRejectJob)
                
                let btnAcceptJob = UIButton(type: .custom)
                btnAcceptJob.backgroundColor = UIColor.JGGCyan
                btnAcceptJob.titleLabel?.font = UIFont.JGGButton
                btnAcceptJob.setTitle(LocalizedString("Accept Job"), for: .normal)
                btnAcceptJob.setTitleColor(UIColor.JGGWhite, for: .normal)
                btnAcceptJob.addTarget(self, action: #selector(onPressedAcceptJob(_:)), for: .touchUpInside)
                tableFooterView.addSubview(btnAcceptJob)
                
                btnRejectJob.snp.makeConstraints({ (maker) in
                    maker.left.top.bottom.equalToSuperview()
                    maker.right.equalTo(btnAcceptJob.snp.left).offset(0)
                })
                btnAcceptJob.snp.makeConstraints({ (maker) in
                    maker.top.right.bottom.equalToSuperview()
                    maker.width.equalTo(btnRejectJob.snp.width).offset(0)
                })
                
                self.tableView.tableFooterView = tableFooterView
            }
        }
    }

    
    // MARK: Button actions
    
    /// Open Map
    @objc fileprivate func onPressedMapLocation(_ sender: UIButton) {
        let appointmentStoryboard = UIStoryboard(name: "Appointment", bundle: nil)
        let mapLocationVC = appointmentStoryboard.instantiateViewController(withIdentifier: "JGGLocationMapVC")
        self.navigationController?.pushViewController(mapLocationVC, animated: true)
    }
    
    /// View Original Service Post
    @objc fileprivate func onPressedViewOriginalServicePost(_ sender: UIButton) {
        let vc = JGGServiceDetailVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    /// Reject Job
    @objc fileprivate func onPressedRejectJob(_ sender: UIButton) {
        JGGAlertViewController.show(title: LocalizedString("Reject this job?"),
                                    message: nil,
                                    colorSchema: .cyan,
                                    okButtonTitle: LocalizedString("Reject"),
                                    okAction: {
            self.parent?.navigationController?.popToRootViewController(animated: true)
        },
                                    cancelButtonTitle: LocalizedString("Cancel"),
                                    cancelAction: nil)
    }
    
    /// Accept Job
    @objc fileprivate func onPressedAcceptJob(_ sender: UIButton) {
        
    }
}

extension JGGAppClientServiceDetailVC { // }: UITableViewDataSource, UITableViewDelegate {
    
    /// Section
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // Header
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == SECTION_PROVIDER {
            return 40
        }
        else if section == SECTION_JOB_DETAIL {
            return 70
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == SECTION_PROVIDER {
            let sectionTitleView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "JGGSectionTitleView") as? JGGSectionTitleView
            sectionTitleView?.title = LocalizedString("Invited service provider:")
            return sectionTitleView
        }
        else if section == SECTION_JOB_DETAIL {
            let jobDetailHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "JGGDetailInfoHeaderView") as? JGGDetailInfoHeaderView
            jobDetailHeaderView?.btnExpand.isSelected = isExandedJobDetail
            jobDetailHeaderView?.btnExpand.addTarget(self, action: #selector(onPressExpand(_:)), for: .touchUpInside)
            if selectedAppointment?.type == .jobs {
                jobDetailHeaderView?.btnExpand.setImage(UIImage(named: "button_showless_cyan"), for: .normal)
                jobDetailHeaderView?.btnExpand.setImage(UIImage(named: "button_showmore_cyan"), for: .selected)
            }
            self.jobDetailHeaderView = jobDetailHeaderView
            return jobDetailHeaderView
        } else {
            return nil
        }
    }
    
    // Footer
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == SECTION_PROVIDER {
            return 0
        }
        else if section == SECTION_JOB_DETAIL {
            return 50
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == SECTION_JOB_DETAIL {
            let jobDetailFooterView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "JGGDetailInfoFooterView") as? JGGDetailInfoFooterView
            jobDetailFooterView?.text = "Job posted on 12 Jul, 2017 8:16 PM"
            return jobDetailFooterView
        } else {
            return nil
        }
    }
    
    
    /// Cell
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == SECTION_PROVIDER {
            return 1
        }
        else if section == SECTION_JOB_DETAIL {
            if let jobDetailHeaderView = jobDetailHeaderView,
                jobDetailHeaderView.btnExpand.isSelected == true {
                return 7
            } else {
                return 0
            }
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let row = indexPath.row
        if section == SECTION_PROVIDER {
            let providerCell = tableView.dequeueReusableCell(withIdentifier: "JGGUserAvatarNameRateCell") as! JGGUserAvatarNameRateCell
            providerCell.lblUsername.text = "Alan.Tam"
            return providerCell
        }
        else if section == SECTION_JOB_DETAIL {
            if row == 0 {
                let carouselViewCell = tableView.dequeueReusableCell(withIdentifier: "JGGImageCarouselCell") as! JGGImageCarouselCell
                carouselViewCell.imgviewJobSummary.image = UIImage(named: "carousel01.jpg")
//                carouselViewCell.carouselView.delegate = self
//                carouselViewCell.carouselView.type = .normal
//                carouselViewCell.carouselView.selectedIndex = 0
                return carouselViewCell
            }
            else if row == 1 || row == 2 || row == 4 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "JGGDetailInfoDescriptionCell") as! JGGDetailInfoDescriptionCell
                if row == 1 {
                    cell.icon = UIImage(named: "icon_budget")
                    cell.title = "$ 10.00 - $ 100.00"
                    cell.lblTitle.font = UIFont.JGGListTitle
                }
                else if row == 2 {
                    cell.icon = UIImage(named: "icon_info")
                    cell.title = "We are experts at gardening & landscaping. Please state in your quotation: size of your garden, what tasks you need done, and any special requirement"
                    cell.lblTitle.font = UIFont.JGGListText
                }
                else if row == 4 {
                    cell.icon = UIImage(named: "icon_completion")
                    let requestsString = LocalizedString("Requests:")
                    let text = requestsString + " " + "Before & After photos"
                    let attributes = [ NSAttributedStringKey.font : UIFont.JGGListTitle ]
                    let regularAttributes = [ NSAttributedStringKey.font : UIFont.JGGListText ]
                    let attributedString = NSMutableAttributedString(string: text, attributes: attributes)
                    let regularRange = NSRange(location: requestsString.count, length: text.count - requestsString.count)
                    attributedString.addAttributes(regularAttributes, range: regularRange)
                    cell.lblTitle.attributedText = attributedString
                }
                return cell
            }
            else if row == 3 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "JGGDetailInfoAccessoryButtonCell") as! JGGDetailInfoAccessoryButtonCell
                cell.icon = UIImage(named: "icon_location")
                cell.title = "2 Jurong West Avenue 5 6437327"
                cell.lblTitle.font = UIFont.JGGListText
                if selectedAppointment?.type == .service {
                    cell.btnAccessory.addTarget(self,
                                                action: #selector(onPressedMapLocation(_:)),
                                                for: .touchUpInside)
                } else {
                    cell.btnAccessory.isHidden = true
                }
                return cell
            }
            else if row == 5 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "JGGDetailInfoCenterAlignCell") as! JGGDetailInfoCenterAlignCell
                cell.title = LocalizedString("Job reference no:") + " " + "J39482-2934882"
                cell.subTitle = LocalizedString("Posted on") + " " + "12 Jul, 2017"
                return cell
            }
            else if row == 6 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "JGGBorderButtonCell") as! JGGBorderButtonCell
                cell.buttonTitle = LocalizedString("View Original Servicce Post")
                if selectedAppointment?.type == .service {
                    cell.btnPrimary.borderColor = UIColor.JGGGreen
                    cell.btnPrimary.setTitleColor(UIColor.JGGGreen, for: .normal)
                } else if selectedAppointment?.type == .jobs {
                    cell.btnPrimary.borderColor = UIColor.JGGCyan
                    cell.btnPrimary.setTitleColor(UIColor.JGGCyan, for: .normal)
                } else if selectedAppointment?.type == .event {
                    cell.btnPrimary.borderColor = UIColor.JGGPurple
                    cell.btnPrimary.setTitleColor(UIColor.JGGPurple, for: .normal)
                }
                cell.btnPrimary.addTarget(self,
                                          action: #selector(onPressedViewOriginalServicePost(_:)),
                                          for: .touchUpInside)
                return cell
            }
        }
        
        return UITableViewCell()
    }

    /// Expand job detail
    @objc func onPressExpand(_ sender: Any) {
        isExandedJobDetail = !isExandedJobDetail
        if let button = sender as? UIButton {
            button.isSelected = isExandedJobDetail
        }
        self.tableView.reloadSections(IndexSet(integer: 1), with: .automatic)
    }
}

extension JGGAppClientServiceDetailVC: TGLParallaxCarouselDelegate  {
    func numberOfItemsInCarouselView(_ carouselView: TGLParallaxCarousel) -> Int {
        return 3
    }
    
    func carouselView(_ carouselView: TGLParallaxCarousel, itemForRowAtIndex index: Int) -> TGLParallaxCarouselItem {
        return JGGCarouselImageView(frame: carouselView.bounds)
    }
    
    func carouselView(_ carouselView: TGLParallaxCarousel, willDisplayItem item: TGLParallaxCarouselItem, forIndex index: Int) {
        if let imageView = item as? JGGCarouselImageView {
            let fileName = String(format: "carousel%02d.jpg", index + 1)
            imageView.imageView.image = UIImage(named: fileName)
        }
    }
    
    func carouselView(_ carouselView: TGLParallaxCarousel, didSelectItemAtIndex index: Int) {
        
    }
}
