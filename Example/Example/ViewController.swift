//
//  ViewController.swift
//  Example
//
//  Created by Lekshmi Raveendranathapanicker on 2/5/18.
//  Copyright © 2018 Lekshmi Raveendranathapanicker. All rights reserved.
//

import UIKit
import Spotlight

class ViewController: UIViewController {

    @IBOutlet weak var spotlightLabel: UILabel!
    @IBOutlet weak var verticalView: UIView!

    @IBAction func startTutorial() {

        Spotlight.delay = 5.0

        guard let rightBB1 = navigationItem.rightBarButtonItem,
            let leftBB1 = navigationItem.leftBarButtonItem,
            let navBar = navigationController?.navigationBar else { return }

        let n0 = SpotlightNode(text: "Sit back and let Spotlight auto advance, or tap anywhere on screen to advance manually", target: .point(.zero, radius: 0))
        let n1 = SpotlightNode(text: "Show spotlight on a bar button item", target: .barButton(leftBB1))
        let n2 = SpotlightNode(text: "Moved spotlight to the title using a point and radius", target: .point(CGPoint(x: view.bounds.width / 2.0, y: navBar.frame.midY), radius: 30))
        let n3 = SpotlightNode(text: "Moved the spotlight again. Targets can be views, barbuttons, tab bar items, points and more", target: .barButton(rightBB1))
        let n4 = SpotlightNode(text: "The Info view can move around to prevent intersection with spotlight", target: .view(verticalView))
        let n5 = SpotlightNode(text: "The End", target: .view(spotlightLabel))

        let nodes = [n0, n1, n2, n3, n4, n5]

        let spotlight = Spotlight()
        spotlight.delegate = self
        spotlight.startIntro(from: self, withNodes: nodes)
    }
}

extension ViewController: SpotlightDelegate {
    func didAdvance(to: Int, of total: Int) {
        print("Showing spotlight \(to) of \(total)")
    }
}
