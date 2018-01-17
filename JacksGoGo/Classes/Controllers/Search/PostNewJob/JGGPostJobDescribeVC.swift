//
//  JGGPostJobDescribeVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 12/28/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGPostJobDescribeVC: JGGPostServiceDescribeVC {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func updateData(_ sender: Any) {
        if let parentVC = parent as? JGGPostJobStepRootVC {
            let creatingJob = parentVC.creatingJob
            creatingJob.title = txtServiceTitle.text
            creatingJob.description_ = txtServiceDescribe.text
            creatingJob.tags = txtTags.text
            creatingJob.attachmentImages = selectedImages.flatMap { $0.1 }
        }
    }
}
