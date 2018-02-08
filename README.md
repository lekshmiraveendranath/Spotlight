# Spotlight
Introductory walkthrough framework for iOS Apps (inspired by [Gecco](https://github.com/yukiasai/Gecco), Rewrite to make it simpler)

![Demo](Spotlight.gif)

## Usage

#### Basic

Setting up Spotlight is really simple and takes only a few lines of code. There are convenience initializers for views and bar buttons and more choices.
``` swift
import Spotlight

class ViewController: UIViewController {

    func startIntro() {
        let nodes = [SpotlightNode(text: "Show Spotlight on a Bar button item", target: .barButton(navigationItem.rightBarButtonItem)),
        SpotlightNode(text: "Show Spotlight on a View", target: .view(nameLabel)),
        SpotlightNode(text: "Show Spotlight at a point location", target: .point(CGPoint(x: 100, y: 100), radius: 50))]

        Spotlight().startIntro(from: self, withNodes: nodes)
    }

}
```

## Installation

#### CocoaPods

```
pod 'LRSpotlight'
```
#### Carthage

```
github "lekshmiraveendranath/Spotlight"
```

## Feature

- [ ] Easy to integrate, just few lines of code
- [ ] Code based Spotlights, no need for an additional storyboard scene per screen for laying out text as in Gecco
- [ ] Timer based automatic forwarding (configurable)
- [ ] Convenience initializers for view and bar button items
- [ ] Swift 4
