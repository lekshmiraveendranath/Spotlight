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

enum ButtonTitles: String {
    case back = "Back"
    case next = "Next"
}

extension SpotlightViewController {

    func setup() {
        modalPresentationStyle = .overCurrentContext
    }

    func setupSpotlightView() {
        spotlightView.frame = UIScreen.main.bounds
        spotlightView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        spotlightView.isUserInteractionEnabled = false
        view.insertSubview(spotlightView, at: 0)
        view.addConstraints([NSLayoutAttribute.top, .bottom, .left, .right].map {
            NSLayoutConstraint(item: view, attribute: $0, relatedBy: .equal, toItem: spotlightView, attribute: $0, multiplier: 1, constant: 0)
        })
    }

    func setupInfoView() {
        let backButton = createButton()
        backButton.setTitle(ButtonTitles.back.rawValue, for: .normal)
        let nextButton = createButton()
        nextButton.setTitle(ButtonTitles.next.rawValue, for: .normal)
        let spacerView = UIView()
        spacerView.backgroundColor = .clear
        let buttonsStack = UIStackView(arrangedSubviews: [backButton, spacerView, nextButton])
        buttonsStack.axis = .horizontal
        buttonsStack.distribution = .fill

        infoLabel = createLabel()
        infoStackView = UIStackView(arrangedSubviews: [infoLabel, buttonsStack])
        infoStackView.axis = .vertical
        infoStackView.distribution = .fill
        infoStackView.spacing = 8

//        let stackBackgroundView = UIView()
//        stackBackgroundView.backgroundColor = .white
//        stackBackgroundView.layer.cornerRadius = 5.0
//        stackBackgroundView.alpha = 0.5
//        stackBackgroundView.embedAndpin(to: infoStackView)
        
        view.addSubview(infoStackView)

        infoStackView.translatesAutoresizingMaskIntoConstraints = false
        infoStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        infoStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        infoStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        infoStackTopConstraint = infoStackView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 44)
        infoStackBottomConstraint = infoStackView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: -44)
        infoStackTopConstraint.priority = .defaultLow
        infoStackBottomConstraint.priority = .defaultHigh
        infoStackTopConstraint.isActive = true
        infoStackBottomConstraint.isActive = true
    }

    func createButton() -> UIButton {
        let button = UIButton()
        button.titleLabel?.font = spotlightNodes.first?.font.withSize(12)
        button.setTitleColor(spotlightNodes.first?.textColor, for: .normal)
        button.layer.borderColor = spotlightNodes.first?.textColor.cgColor
        button.layer.cornerRadius = 5.0
        button.layer.borderWidth = 1.0
        button.widthAnchor.constraint(equalToConstant: 44).isActive = true
        button.addTarget(self, action: #selector(SpotlightViewController.buttonPressed(_:)), for: .touchUpInside)

        return button
    }

    func createLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = spotlightNodes.first?.font
        label.textColor = spotlightNodes.first?.textColor
        label.textAlignment = .center
        return label
    }

    func setupTapGestureRecognizer() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(SpotlightViewController.viewTapped(_:)))
        view.addGestureRecognizer(gesture)
    }
}
