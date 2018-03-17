//
//  Spotlight.swift
//  Spotlight
//
//  Created by Lekshmi Raveendranathapanicker on 2/5/18.
//  Copyright © 2018 Lekshmi Raveendranathapanicker. All rights reserved.
//

import Foundation
import UIKit

public struct Spotlight {

    public static var delay: TimeInterval = 3.0
    public static var animationDuration: TimeInterval = 0.25
    public static var alpha: CGFloat = 0.6
    public static var showInfoBackground: Bool = true
    public static var textColor: UIColor = .white
    public static var font: UIFont = UIFont(name: "Futura", size: 18)!

    public init() {}

    public func startIntro(from controller: UIViewController, withNodes nodes: [SpotlightNode]) {
        guard nodes.count > 0 else { return }
        vc.spotlightNodes = nodes
        controller.present(vc, animated: true, completion: nil)
    }

    private let vc = SpotlightViewController()
}
