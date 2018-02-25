//
//  SpotlightNode.swift
//  Spotlight
//
//  Created by Lekshmi Raveendranathapanicker on 2/21/18.
//  Copyright © 2018 Lekshmi Raveendranathapanicker. All rights reserved.
//

import Foundation

public enum SpotlightTarget {

    case view(UIView)
    case barButton(UIBarButtonItem)
    case tabBarItem(UITabBarController, Int)
    case point(CGPoint, radius: CGFloat)
    case rect(CGRect)

    var targetView: UIView {
        let target: UIView
        switch self {
        case let .view(view):
            target = view
        case let .barButton(barButtonItem):
            target = barButtonItem.value(forKey: "view") as! UIView
        case let .tabBarItem(tabBarController, index):
            let tabBarItems = tabBarController.tabBar.subviews.filter({ $0.isUserInteractionEnabled })
            guard index > -1, tabBarItems.count > index else { return UIView() }
            let tabBarItemView = tabBarItems[index]
            let frame = CGRect(x: tabBarItemView.frame.midX - 22, y: tabBarController.tabBar.frame.origin.y, width: 44, height: 44)
            target = UIView(frame: frame)
        case let .point(center, radius):
            target = UIView(frame: CGRect(x: 0, y: 0, width: radius * 2, height: radius * 2))
            target.center = center
        case let .rect(frame):
            target = UIView(frame: frame)
        }
        return target
    }

    func path(translater: UIView) -> UIBezierPath {
        let translatedFrame = targetView.convert(targetView.bounds, to: translater)
        let spotlightFrame = translatedFrame.insetBy(dx: -8.0, dy: -8.0) // Add some breathing space for the spotlight
        return UIBezierPath(roundedRect: spotlightFrame, cornerRadius:spotlightFrame.height / 2.0)
    }

    func infinitesmalPath(translater: UIView) -> UIBezierPath {
        let spotlightFrame = targetView.convert(targetView.bounds, to: translater)
        let spotlightCenter = CGPoint(x: spotlightFrame.midX, y: spotlightFrame.midY)
        return UIBezierPath(roundedRect: CGRect(origin: spotlightCenter, size: CGSize.zero), cornerRadius: 0)
    }

}
