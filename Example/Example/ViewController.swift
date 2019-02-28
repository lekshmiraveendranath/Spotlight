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
        wrapper.startTutorial()
    }

    private lazy var wrapper: SpotlightWrapper = SpotlightWrapper(with: self)
}
