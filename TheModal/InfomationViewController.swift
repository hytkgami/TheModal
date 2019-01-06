//
//  InfomationViewController.swift
//  TheModal
//
//  Created by Hajime Kagami on 2019/01/06.
//  Copyright © 2019 Hajime Kagami. All rights reserved.
//

import UIKit

class InfomationViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        let date = Date(timeIntervalSinceNow: 0)
        titleLabel.text = date.description
    }
}
