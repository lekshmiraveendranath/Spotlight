//
//  SpotlightWrapper.swift
//  Example
//
//  Created by Lekshmi Raveendranathapanicker on 2/27/19.
//  Copyright © 2018 Lekshmi Raveendranathapanicker. All rights reserved.
//

import Foundation
import Spotlight
import UIKit

/*
 This approach of a wrapper is not needed for pure swift projects, or if you are planning to display Spotlight from swift code.

 Objective-C can't use enums with associated values or structs.
 If Spotlight needs to be displayed from Objective-C, then use a similar approach as in this class.
 */
@objc
final class SpotlightWrapper: NSObject {
    @available(*, unavailable, message: "Use init(with viewController:) instead")
    private override init() {}
    private var viewController: UIViewController?

    init(with viewController: UIViewController) {
        self.viewController = viewController
    }

    func startTutorial() {
        guard let viewController = viewController as? ViewController else { return }

        guard let rightBB1 = viewController.navigationItem.rightBarButtonItem,
            let leftBB1 = viewController.navigationItem.leftBarButtonItem,
            let navBar = viewController.navigationController?.navigationBar else { return }

        let node0 = SpotlightNode(text: "Sit back and let Spotlight auto advance, or tap anywhere on screen to advance manually",
                                  target: .point(.zero, radius: 0))
        let node1 = SpotlightNode(text: "Show spotlight on a bar button item",
                                  target: .barButton(leftBB1), roundedCorners: false)
        let node2 = SpotlightNode(text: "Moved spotlight to the title using a point and radius",
                                  target: .point(CGPoint(x: viewController.view.bounds.width / 2.0, y: navBar.frame.midY), radius: 30))
        let node3 = SpotlightNode(text: "Moved the spotlight again. Targets can be views, barbuttons, tab bar items, points and more", target: .barButton(rightBB1))
        let node4 = SpotlightNode(text: "The Info view can move around to prevent intersection with spotlight", target: .view(viewController.verticalView))
        let node5 = SpotlightNode(text: "The End", target: .view(viewController.spotlightLabel))

        let nodes = [node0, node1, node2, node3, node4, node5]

        Spotlight.delay = 5.0
        let spotlight = Spotlight()
        spotlight.delegate = self
        spotlight.startIntro(from: viewController, withNodes: nodes)
    }
}

extension SpotlightWrapper: SpotlightDelegate {
    func spotlightDidAdvance(to node: Int, of total: Int) {
        print("Showing Spotlight \(node) of \(total)")
    }

    func spotlightDidDismiss() {
        print("Spotlight was dismissed")
    }
}
