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
        
        UIView.animate(withDuration: 0.5) { [weak self] in
            guard let self = self else { return }
            
            self.infoStackBottomConstraint.constant = -44
            self.spotlightView.backgroundColor = Spotlight.backgroundColor
            
            self.view.layoutIfNeeded()
        }
        
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(setupFirstSpotlight), userInfo: nil, repeats: false)
    }
    
    @objc
    private func setupFirstSpotlight() {
        self.nextSpotlight()

        self.timer = Timer.scheduledTimer(timeInterval: Spotlight.delay, target: self, selector: #selector(self.nextSpotlight), userInfo: nil, repeats: true)
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
        showSpotlight()
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
        currentNodeIndex += 1
        showSpotlight()
    }

    func previousSpotlight() {
        if currentNodeIndex == 0 {
            dismissSpotlight()
            return
        }
        currentNodeIndex -= 1
        showSpotlight()
    }

    func showSpotlight() {
        let node = spotlightNodes[currentNodeIndex]

        nextButton.isHidden = (currentNodeIndex == spotlightNodes.count - 1)
        backButton.isHidden = (currentNodeIndex == 0)

        let targetRect: CGRect
        switch currentNodeIndex {
        case 0:
            targetRect = spotlightView.appear(node)
        case let index where index == spotlightNodes.count:
            targetRect = spotlightView.disappear(node)
        default:
            targetRect = spotlightView.move(node)
        }

        let newNodeIndex = currentNodeIndex + 1
        delegate?.didAdvance(to: newNodeIndex, of: spotlightNodes.count)

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
        delegate?.didDismiss()
    }
}
