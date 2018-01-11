//
//  JGGServiceModel.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 26/10/2017.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit
import MapKit
import SwiftyJSON

class JGGServiceModel: JGGAppointmentBaseModel, MKAnnotation {
    
    override var type: AppointmentType {
        get {
            return .service
        }
    }
    
    var invitingClient: JGGClientUserModel?
    
    var coordinate: CLLocationCoordinate2D
    
    var subtitle: String?
    
    override init(json: JSON) {
        coordinate = CLLocationCoordinate2DMake(0, 0)
        super.init(json: json)
        
    }
    
    override init() {
        coordinate = CLLocationCoordinate2DMake(0, 0)
        super.init()
    }
}
