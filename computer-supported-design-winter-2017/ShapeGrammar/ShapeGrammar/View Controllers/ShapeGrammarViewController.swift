//
//  ShapeGrammarViewController.swift
//  ShapeGrammar
//
//  Created by Witold Bobrowski on 24/10/2017.
//

import UIKit

class ShapeGrammarViewController: UIViewController {
    
    
    @IBOutlet private weak var label: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var shapeContainerView: UIView!
    @IBOutlet private weak var randomButton: UIButton!
    @IBOutlet private weak var clearButton: UIButton!
    private let gradient = CAGradientLayer()
    private var shapeView: ShapeView?
    private let brain = ShapeGrammarBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureLabel()
        configureShapeView()
        configureButton()
    }
    
    @objc private func backgroundDidTap(_ recognizer: UITapGestureRecognizer) {
        if descriptionLabel.alpha == 1 {
            brain.setup()
            toggleViews(descriptionShouldHide: true)
        }
        brain.evolve()
    }

    @objc private func clearButtonDidTap(_ sender: UIButton) {
        clear()
        toggleViews(descriptionShouldHide: false)
    }
    
    @objc private func randomButtonDidTap(_ sender: UIButton) {
        clear()
        toggleViews(descriptionShouldHide: true)
        brain.random()
    }
    
}

//MARK: - Configuration
extension ShapeGrammarViewController {
    
    private func configure() {
        gradient.frame = view.layer.bounds
        view.layer.insertSublayer(gradient, at: 0)
        gradient.colors = [UIColor(red: 182/255, green: 251/255, blue: 255/255, alpha: 1).cgColor, UIColor(red: 131/255, green: 164/255, blue: 212/255, alpha: 1).cgColor]
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundDidTap(_:)))
        view.addGestureRecognizer(tapGesture)
        brain.delegate = self
    }
    
    private func configureLabel() {
        label.text = "ShapeGrammar"
        descriptionLabel.text = "Tap to grow the shape"
        [label, descriptionLabel].forEach {
            $0?.textColor = UIColor(red: 66/255, green: 66/255, blue: 66/255, alpha: 1)
            $0?.textAlignment = .center
        }
    }
    
    private func configureShapeView() {
        let shapeView = ShapeView(frame: shapeContainerView.bounds)
        shapeContainerView.addSubview(shapeView)
        shapeContainerView.backgroundColor = .clear
        shapeContainerView.alpha = 0
        shapeView.isOpaque = false
        shapeView.color = UIColor(red: 66/255, green: 66/255, blue: 66/255, alpha: 1)
        self.shapeView = shapeView
    }
    
    private func configureButton() {
        randomButton.tintColor = UIColor(red: 66/255, green: 66/255, blue: 66/255, alpha: 1)
        randomButton.addTarget(self, action: #selector(randomButtonDidTap(_:)), for: .touchUpInside)
        clearButton.backgroundColor = UIColor(red: 255/255, green: 44/255, blue: 36/255, alpha: 1)
        clearButton.setTitle("Clear", for: .normal)
        clearButton.setTitleColor(.white, for: .normal)
        clearButton.addTarget(self, action: #selector(clearButtonDidTap(_:)), for: .touchUpInside)
        clearButton.layer.cornerRadius = 8
    }
    
    private func clear() {
        shapeView?.addPathForShape(nil)
        brain.clear()
    }
    
    private func toggleViews(descriptionShouldHide: Bool) {
        UIView.animateKeyframes(withDuration: 1, delay: 0, options: [.calculationModeCubic], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                if descriptionShouldHide {
                    self.descriptionLabel.alpha = 0
                } else {
                    self.shapeContainerView.alpha = 0
                }
            })
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                if descriptionShouldHide {
                    self.shapeContainerView.alpha = 1
                } else {
                    self.descriptionLabel.alpha = 1
                }
            })
        }, completion: nil)
    }
    
}

//MARK: - ShapeGrammarBrainDelegate
extension ShapeGrammarViewController: ShapeGrammarBrainDelegate {
    
    func rectForDrawing(_ shapeGrammarBraint: ShapeGrammarBrain) -> CGRect? {
        return shapeView?.bounds
    }
    
    func shapeGrammarBrain(_ shapeGrammarBrain: ShapeGrammarBrain, didFinishBuildingGrammar grammar: Grammar<Shape>) {
        var nodes = [grammar.head]
        shapeView?.addPathForShape(nil)
        while let current = nodes.popLast() {
            shapeView?.addPathForShape(current.element)
            nodes.append(contentsOf: current.nodes.values)
        }
    }
    
    func shapeGrammarBrain(_ shapeGrammarBrain: ShapeGrammarBrain, didFinishCalculatingScore score: Int) {
        print(score)
    }
    
}
