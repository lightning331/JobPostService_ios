//
//  JGGJobModel.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 26/10/2017.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGJobModel: JGGAppointmentBaseModel {

    override var type: AppointmentType {
        get {
            return .jobs
        }
    }
    
    var biddingProviders: [JGGBiddingProviderModel] = []
    var invitedProviders: [JGGProviderUserModel] = []
    
}
