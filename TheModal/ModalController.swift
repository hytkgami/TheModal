//
//  ModalController.swift
//  TheModal
//
//  Created by Hajime Kagami on 2018/12/19.
//  Copyright © 2018 Hajime Kagami. All rights reserved.
//

import UIKit

class ModalController: UIPresentationController {
    // 呼び出し元の View Controller の上に重ねるオーバーレイ View
    var overlay: UIView!

    // 表示トランジション開始前に呼ばれる
    override func presentationTransitionWillBegin() {
        let containerView = self.containerView!

        self.overlay = UIView(frame: containerView.bounds)
        self.overlay.gestureRecognizers = [UITapGestureRecognizer(target: self, action: #selector(self.overlayDidTouch(_:)))]
        self.overlay.isUserInteractionEnabled = true
        self.overlay.backgroundColor = UIColor.black
        self.overlay.alpha = 0.0
        containerView.insertSubview(self.overlay, at: 0)

        // トランジションを実行
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: {
            [unowned self] context in
            self.overlay.alpha = 0.5
            }, completion: nil)
    }

    // 非表示トランジション開始前に呼ばれる
    override func dismissalTransitionWillBegin() {
        self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: {
            [unowned self] context in
            self.overlay.alpha = 0.0
            }, completion: nil)
    }

    // 非表示トランジション開始後に呼ばれる
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed {
            self.overlay.removeFromSuperview()
        }
    }

    // 子のコンテナのサイズを返す
    let margin = (x: CGFloat(30), y: CGFloat(220))
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        return CGSize(width: parentSize.width - margin.x, height: parentSize.height - margin.y)
    }

    // 呼び出し先の View Controller の Frame を返す
    override var frameOfPresentedViewInContainerView: CGRect {
        var presentedViewFrame = CGRect.zero
        let containerBounds = containerView!.bounds
        presentedViewFrame.size = self.size(forChildContentContainer: self.presentedViewController, withParentContainerSize: containerBounds.size)
        presentedViewFrame.origin.x = margin.x / 2.0
        presentedViewFrame.origin.y = margin.y / 2.0

        return presentedViewFrame
    }

    // レイアウト開始前に呼ばれる
    override func containerViewWillLayoutSubviews() {
        overlay.frame = containerView!.bounds
        self.presentedView!.frame = self.frameOfPresentedViewInContainerView
    }



    // レイアウト開始後に呼ばれる
    override func containerViewDidLayoutSubviews() {
    }

    // オーバーレイの View をタッチしたときに呼ばれる
    @objc func overlayDidTouch(_ sender: UITapGestureRecognizer) {
        self.presentedViewController.dismiss(animated: true, completion: nil)
    }

}
