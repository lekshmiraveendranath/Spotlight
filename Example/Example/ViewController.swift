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

        guard let rightBB1 = navigationItem.rightBarButtonItem, let leftBB1 = navigationItem.leftBarButtonItem else { return }

        let n1 = SpotlightNode(text: "Show spotlight on a bar button item", target: .barButton(rightBB1))
        let n2 = SpotlightNode(text: "Moved spotlight to the title using a point and radius", target: .point(CGPoint(x: view.bounds.width / 2.0, y: 44), radius: 25))
        let n3 = SpotlightNode(text: "Moved the spotlight again", target: .barButton(leftBB1))
        let n4 = SpotlightNode(text: "Can higlight individual views, and this view can move around to prevent intersection with spotlight", target: .view(verticalView))
        let n5 = SpotlightNode(text: "", target: .point(CGPoint(x: view.bounds.width / 2.0, y: 214), radius: 116))

         let nodes = [n1, n2, n3, n4, n5]
         Spotlight().startIntro(from: self, withNodes: nodes)
    }

}

