//
//  APIConstant.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 1/10/18.
//  Copyright © 2018 Hemin Wang. All rights reserved.
//

import Foundation

public enum JGGJobType: Int {
    case none = -1
    case repeating = 0
    case oneTime = 1
}

public enum JGGRepetitionType: Int {
    case weekly = 0
    case monthly = 1
}

public enum JGGAppointmentType: Int {
    case job = 0
    case service = 1
    case goclub = 2
}
