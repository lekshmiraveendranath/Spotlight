//
//  Spotlight.swift
//  Spotlight
//
//  Created by Lekshmi Raveendranathapanicker on 2/5/18.
//  Copyright © 2018 Lekshmi Raveendranathapanicker. All rights reserved.
//

import Foundation
import UIKit

public protocol SpotlightDelegate: AnyObject {
    func didAdvance(to node: Int, of total: Int)
    func didDismiss()
}

public final class Spotlight {
    public static var delay: TimeInterval = 3.0
    public static var animationDuration: TimeInterval = 0.25
    public static var alpha: CGFloat = 0.6
    public static var backgroundColor: UIColor = .black
    public static var textColor: UIColor = .white
    public static var font: UIFont = UIFont(name: "Futura", size: 18)!
    public static var showInfoBackground: Bool = true
    public static var infoBackgroundEffect: UIBlurEffect.Style = .light
    public static var backButtonTitle = "Back"
    public static var nextButtonTitle = "Next"

    public weak var delegate: SpotlightDelegate?

    public init() {}

    public func startIntro(from controller: UIViewController, withNodes nodes: [SpotlightNode]) {
        guard !nodes.isEmpty else { return }
        spotlightVC.spotlightNodes = nodes
        spotlightVC.delegate = delegate
        controller.present(spotlightVC, animated: true, completion: nil)
    }

    private let spotlightVC = SpotlightViewController()
}
