//
//  ViewController.swift
//  Example
//
//  Created by Lekshmi Raveendranathapanicker on 2/5/18.
//  Copyright © 2018 Lekshmi Raveendranathapanicker. All rights reserved.
//

import Spotlight
import UIKit

final class ViewController: UIViewController {
    @IBOutlet var spotlightLabel: UILabel!
    @IBOutlet var verticalView: UIView!

    @IBAction func startTutorial() {
        Spotlight.delay = 5.0

        guard let rightBB1 = navigationItem.rightBarButtonItem,
            let leftBB1 = navigationItem.leftBarButtonItem,
            let navBar = navigationController?.navigationBar else { return }

        let node0 = SpotlightNode(text: "Sit back and let Spotlight auto advance, or tap anywhere on screen to advance manually", target: .point(.zero, radius: 0))
        let node1 = SpotlightNode(text: "Show spotlight on a bar button item", target: .barButton(leftBB1))
        let node2 = SpotlightNode(text: "Moved spotlight to the title using a point and radius", target: .point(CGPoint(x: view.bounds.width / 2.0, y: navBar.frame.midY), radius: 30))
        let node3 = SpotlightNode(text: "Moved the spotlight again. Targets can be views, barbuttons, tab bar items, points and more", target: .barButton(rightBB1))
        let node4 = SpotlightNode(text: "The Info view can move around to prevent intersection with spotlight", target: .view(verticalView))
        let node5 = SpotlightNode(text: "The End", target: .view(spotlightLabel))

        let nodes = [node0, node1, node2, node3, node4, node5]

        let spotlight = Spotlight()
        spotlight.delegate = self
        spotlight.startIntro(from: self, withNodes: nodes)
    }
}

extension ViewController: SpotlightDelegate {
    func didAdvance(to node: Int, of total: Int) {
        print("Showing Spotlight \(node) of \(total)")
    }

    func didDismiss() {
        print("Spotlight was dimissed")
    }
}
