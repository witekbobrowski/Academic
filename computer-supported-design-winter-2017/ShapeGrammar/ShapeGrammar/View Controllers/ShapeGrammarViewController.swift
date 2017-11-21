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
    @IBOutlet private weak var button: UIButton!
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
        guard let shapeView = self.shapeView else {
            return
        }
        UIView.transition(with: shapeView, duration: 0.5, options: [.transitionCrossDissolve], animations: {
            if self.brain.isEmpty {
                self.descriptionLabel.isHidden = true
                self.brain.addShape(Triangle(rect: shapeView.bounds))
            } else {
                self.brain.buildShapes()
            }
        })
    }

    @objc private func buttonDidTap(_ sender: UIButton) {
        shapeView?.addPathForShape(nil)
        brain.clear()
        descriptionLabel.isHidden = false
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
        descriptionLabel.text = "Tap to turn every △ into ✡"
        [label, descriptionLabel].forEach {
            $0?.textColor = UIColor(red: 66/255, green: 66/255, blue: 66/255, alpha: 1)
            $0?.textAlignment = .center
        }
    }
    
    private func configureShapeView() {
        let shapeView = ShapeView(frame: shapeContainerView.bounds)
        shapeContainerView.addSubview(shapeView)
        shapeContainerView.backgroundColor = .clear
        shapeView.isOpaque = false
        shapeView.color = UIColor(red: 66/255, green: 66/255, blue: 66/255, alpha: 1)
        self.shapeView = shapeView
    }
    
    private func configureButton() {
        button.backgroundColor = UIColor(red: 255/255, green: 44/255, blue: 36/255, alpha: 1)
        button.setTitle("Clear", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(buttonDidTap(_:)), for: .touchUpInside)
        button.layer.cornerRadius = 8
    }
    
}

//MARK: - ShapeGrammarBrainDelegate
extension ShapeGrammarViewController: ShapeGrammarBrainDelegate {
    
    func shapeGrammarBrain(_ shapeGrammarBrain: ShapeGrammarBrain, didBuildShape shape: Shape) {
        shapeView?.addPathForShape(shape)
    }
    
}
