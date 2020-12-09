//
//  SpotlightViewController+UISetup.swift
//  Spotlight
//
//  Created by Lekshmi Raveendranathapanicker on 2/5/18.
//  Copyright © 2018 Lekshmi Raveendranathapanicker. All rights reserved.
//

import Foundation
import UIKit

// MARK: - UI Setup

extension SpotlightViewController {
    func setup() {
        modalPresentationStyle = .overFullScreen
    }

    func setupSpotlightView() {
        spotlightView.frame = UIScreen.main.bounds
        spotlightView.backgroundColor = .clear
        spotlightView.alpha = Spotlight.alpha
        spotlightView.isUserInteractionEnabled = false
        guard let view = view else { return }
        view.insertSubview(spotlightView, at: 0)
        view.addConstraints([NSLayoutConstraint.Attribute.top, .bottom, .left, .right].map {
            NSLayoutConstraint(item: view, attribute: $0, relatedBy: .equal, toItem: spotlightView, attribute: $0, multiplier: 1, constant: 0)
        })
    }

    func setupInfoView() {
        let closeButton = createCloseButton()
        let closeStackView = UIStackView(arrangedSubviews: [createSpacer(), closeButton])
        closeStackView.axis = .horizontal
        closeStackView.alignment = .trailing
        closeStackView.heightAnchor.constraint(equalToConstant: 30).isActive = true

        backButton = createButton()
        backButton.setTitle(Spotlight.backButtonTitle, for: .normal)
        backButton.isHidden = true // Will be shown later
        nextButton = createButton()
        nextButton.setTitle(Spotlight.nextButtonTitle, for: .normal)
        let buttonsStack = UIStackView(arrangedSubviews: [backButton, createSpacer(), nextButton])
        buttonsStack.axis = .horizontal

        infoLabel = createLabel()
        if let firstNode = spotlightNodes.first {
            infoLabel.text = firstNode.text
        }
        let combinedStackView = UIStackView(arrangedSubviews: [infoLabel, buttonsStack])
        combinedStackView.axis = .vertical
        combinedStackView.spacing = 10

        infoStackView = UIStackView(arrangedSubviews: [closeStackView, combinedStackView])
        infoStackView.axis = .vertical
        infoStackView.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        infoStackView.isLayoutMarginsRelativeArrangement = true
        infoStackView.spacing = 10

        if Spotlight.showInfoBackground {
            insertBackgroundBlur()
        }

        view.addSubview(infoStackView)

        infoStackView.translatesAutoresizingMaskIntoConstraints = false
        infoStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        infoStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        infoStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        infoStackTopConstraint = infoStackView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 44)
        infoStackBottomConstraint = infoStackView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: -44 + UIScreen.main.bounds.height)
        infoStackTopConstraint.priority = .defaultLow
        infoStackBottomConstraint.priority = .defaultHigh
        infoStackTopConstraint.isActive = true
        infoStackBottomConstraint.isActive = true
    }

    func createButton() -> UIButton {
        let button = UIButton()
        button.titleLabel?.font = Spotlight.font.withSize(12)
        button.setTitleColor(Spotlight.textColor, for: .normal)
        button.layer.borderColor = Spotlight.textColor.cgColor
        button.layer.cornerRadius = 5.0
        button.layer.borderWidth = 1.0
        button.widthAnchor.constraint(equalToConstant: 44).isActive = true
        button.setContentHuggingPriority(UILayoutPriority(1000), for: .horizontal)
        button.addTarget(self, action: #selector(SpotlightViewController.buttonPressed(_:)), for: .touchUpInside)

        return button
    }

    func createCloseButton() -> UIButton {
        let button = UIButton()
        let image = UIImage(named: "Close", in: Bundle(for: type(of: self)), compatibleWith: nil)
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageView?.tintColor = Spotlight.textColor
        button.imageEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        button.widthAnchor.constraint(equalToConstant: 44).isActive = true
        button.setContentHuggingPriority(UILayoutPriority(1000), for: .horizontal)
        button.addTarget(self, action: #selector(SpotlightViewController.buttonPressed(_:)), for: .touchUpInside)

        return button
    }

    func createSpacer() -> UIView {
        let spacerView = UIView()
        spacerView.setContentHuggingPriority(UILayoutPriority(rawValue: 0), for: .horizontal)
        spacerView.backgroundColor = .clear
        return spacerView
    }

    func createLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = Spotlight.font
        label.textColor = Spotlight.textColor
        label.textAlignment = .center
        return label
    }

    func insertBackgroundBlur() {
        let blurEffect = UIBlurEffect(style: Spotlight.infoBackgroundEffect)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)
        let vibrancyEffectView = UIVisualEffectView(effect: vibrancyEffect)
        blurredEffectView.layer.cornerRadius = 10.0
        vibrancyEffectView.layer.cornerRadius = 10.0
        blurredEffectView.clipsToBounds = true
        vibrancyEffectView.clipsToBounds = true
        blurredEffectView.embedAndpin(to: infoStackView)
        vibrancyEffectView.embedAndpin(to: infoStackView)
    }

    func setupTapGestureRecognizer() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(SpotlightViewController.viewTapped(_:)))
        view.addGestureRecognizer(gesture)
    }
}
