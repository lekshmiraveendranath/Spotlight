//
//  SpotlightNode.swift
//  Spotlight
//
//  Created by Lekshmi Raveendranathapanicker on 2/5/18.
//  Copyright © 2018 Lekshmi Raveendranathapanicker. All rights reserved.
//

import Foundation
import UIKit

public struct SpotlightNode {
    var text: String
    var target: SpotlightTarget
    var roundedCorners: Bool

    public init(text: String, target: SpotlightTarget, roundedCorners: Bool = true) {
        self.text = text
        self.target = target
        self.roundedCorners = roundedCorners
    }
}
