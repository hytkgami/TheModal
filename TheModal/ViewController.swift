//
//  ViewController.swift
//  TheModal
//
//  Created by Hajime Kagami on 2018/12/19.
//  Copyright © 2018 Hajime Kagami. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIViewControllerTransitioningDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func buttonDidTap(_ sender: UIButton) {
        let controller: UIViewController = (self.storyboard?.instantiateViewController(withIdentifier: "popup"))!
        controller.modalPresentationStyle = .custom
        controller.transitioningDelegate = self
        self.present(controller, animated: true) {}
    }

    // MARK: UIViewControllerTransitioningDelegate
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return ModalController(presentedViewController: presented, presenting: presenting)
    }

}

