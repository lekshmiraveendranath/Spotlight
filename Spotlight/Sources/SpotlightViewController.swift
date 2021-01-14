//
//  SpotlightViewController.swift
//  Spotlight
//
//  Created by Lekshmi Raveendranathapanicker on 2/5/18.
//  Copyright © 2018 Lekshmi Raveendranathapanicker. All rights reserved.
//

import Foundation
import UIKit

final class SpotlightViewController: UIViewController {
    var spotlightNodes: [SpotlightNode] = []
    weak var delegate: SpotlightDelegate?
    var backButton: UIButton!
    var nextButton: UIButton!

    // MARK: - View Controller Life cycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSpotlightView()
        setupInfoView()
        setupTapGestureRecognizer()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if spotlightNodes.count == 1 {
            backButton.isHidden = true
            nextButton.isHidden = true
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.nextSpotlight()
        
        UIView.animate(withDuration: 0.5) { [weak self] in
            guard let self = self else { return }
            
            self.infoStackBottomConstraint.constant = -44
            self.spotlightView.backgroundColor = Spotlight.backgroundColor
            
            self.view.layoutIfNeeded()
        }
        
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(setupSpotlightDelay), userInfo: nil, repeats: false)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        Spotlight.infoBackgroundGradient?.frame = infoStackView.bounds
        Spotlight.infoBackgroundGradient?.removeAllAnimations()
    }
    
    @objc
    private func setupSpotlightDelay() {
        if Spotlight.delay > 0 {
            self.timer = Timer.scheduledTimer(timeInterval: Spotlight.delay, target: self, selector: #selector(self.nextSpotlight), userInfo: nil, repeats: true)
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        spotlightView.isHidden = true
        timer.invalidate()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        // Redraw spotlight for the new dimention
        spotlightView.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        goToSpotlight(index: currentNodeIndex > 0 ? currentNodeIndex : 0)
    }

    let spotlightView = SpotlightView()
    var infoLabel: UILabel!
    var infoStackView: UIStackView!
    var infoStackTopConstraint: NSLayoutConstraint!
    var infoStackBottomConstraint: NSLayoutConstraint!
    fileprivate var timer = Timer()
    fileprivate var currentNodeIndex: Int = -1
}

// MARK: - User Actions

extension SpotlightViewController {
    @objc func buttonPressed(_ button: UIButton) {
        timer.invalidate()
        let title = button.titleLabel?.text ?? ""
        switch title {
        case Spotlight.nextButtonTitle:
            nextSpotlight()
        case Spotlight.backButtonTitle:
            previousSpotlight()
        default:
            dismissSpotlight()
        }
    }

    @objc func viewTapped(_: UITapGestureRecognizer) {
        timer.invalidate()
        nextSpotlight()
    }

    @objc func nextSpotlight() {
        if currentNodeIndex == spotlightNodes.count - 1 {
            dismissSpotlight()
            return
        }
        goToSpotlight(index: currentNodeIndex + 1)
    }

    func previousSpotlight() {
        if currentNodeIndex == 0 {
            dismissSpotlight()
            return
        }
        goToSpotlight(index: currentNodeIndex - 1)
    }

    private func goToSpotlight(index: Int) {
        let previousNodeIndex = currentNodeIndex
        currentNodeIndex = index
        let previousTarget = previousNodeIndex >= 0 && previousNodeIndex < spotlightNodes.count ? spotlightNodes[previousNodeIndex].target : SpotlightTarget.none
        let node = spotlightNodes[currentNodeIndex]

        nextButton.isHidden = (currentNodeIndex == spotlightNodes.count - 1)
        backButton.isHidden = (currentNodeIndex == 0)

        let targetRect: CGRect
        if previousTarget == .none {
            targetRect = spotlightView.appear(node)
        } else if node.target == .none {
            targetRect = spotlightView.disappear(node)
        } else {
            targetRect = spotlightView.move(node)
        }

        let newNodeIndex = currentNodeIndex + 1
        delegate?.spotlightDidAdvance(to: newNodeIndex, of: spotlightNodes.count)

        infoLabel.text = node.text

        // Animate the info box around if intersects with spotlight
        view.layoutIfNeeded()
        UIView.animate(withDuration: Spotlight.animationDuration, animations: { [weak self] in
            guard let this = self else { return }
            if targetRect.intersects(this.infoStackView.frame) {
                if this.infoStackTopConstraint.priority == .defaultLow {
                    this.infoStackTopConstraint.priority = .defaultHigh
                    this.infoStackBottomConstraint.priority = .defaultLow
                } else {
                    this.infoStackTopConstraint.priority = .defaultLow
                    this.infoStackBottomConstraint.priority = .defaultHigh
                }
            }
            this.view.layoutIfNeeded()
        })
    }

    func dismissSpotlight() {
        dismiss(animated: true, completion: nil)
        delegate?.spotlightDidDismiss()
    }
}
