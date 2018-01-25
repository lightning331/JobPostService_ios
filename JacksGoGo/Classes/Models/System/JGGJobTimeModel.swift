//
//  JGGJobTimeModel.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 1/16/18.
//  Copyright © 2018 Hemin Wang. All rights reserved.
//

import UIKit
import SwiftyJSON

class JGGJobTimeModel: NSObject {

    internal let JobStartOn = "JobStartOn"
    internal let JobEndOn   = "JobEndOn"
    internal let IsSpecific = "IsSpecific"
    internal let Peoples    = "Peoples"
    
    var jobStartOn: Date?
    var jobEndOn: Date?
    var isSpecific: Bool = false
    var peoples: Int?
    
    override init() {
        super.init()
    }
    
    init?(json: JSON?) {
        guard let json = json else {
            return nil
        }
        super.init()
        jobStartOn  = json[JobStartOn].dateObject
        jobEndOn    = json[JobEndOn].dateObject
        isSpecific  = json[IsSpecific].boolValue
        peoples     = json[Peoples].int
    }
    
    init(startOn: Date?, endOn: Date?, isSpecific: Bool, peoples: Int? = nil) {
        super.init()
        self.jobStartOn = startOn
        self.jobEndOn = endOn
        self.isSpecific = isSpecific
        self.peoples = peoples
    }
    
    func json() -> JSON {
        var json = JSON()
        json[JobStartOn].dateObject = jobStartOn
        json[JobEndOn].dateObject = jobEndOn
        json[IsSpecific].boolValue   = isSpecific
        json[Peoples].int = peoples
        return json
    }

}