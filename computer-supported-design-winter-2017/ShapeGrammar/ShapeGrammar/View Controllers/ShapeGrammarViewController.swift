//
//  ShapeGrammarViewController.swift
//  ShapeGrammar
//
//  Created by Witold Bobrowski on 24/10/2017.
//

import UIKit

class ShapeGrammarViewController: UIViewController {
    
    private enum Constants {
        static let inset: CGFloat = 16
    }
    
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
        guard let shapeView = self.shapeView else {
            return
        }
        UIView.transition(with: shapeView, duration: 0.5, options: [.transitionCrossDissolve], animations: {
            if self.brain.isEmpty {
                self.descriptionLabel.isHidden = true
                self.brain.set(Triangle(rect: shapeView.bounds), at: .center)
            } else {
                self.brain.addLayer(at: [.north])
            }
        })
    }

    @objc private func clearButtonDidTap(_ sender: UIButton) {
        clear()
    }
    
    @objc private func randomButtonDidTap(_ sender: UIButton) {
        clear()
        brain.set(Triangle(rect: shapeView?.bounds ?? .zero), at: .center)
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
        descriptionLabel.isHidden = true
    }
    
}

//MARK: - ShapeGrammarBrainDelegate
extension ShapeGrammarViewController: ShapeGrammarBrainDelegate {
    
    func shapeGrammarBrain(_ shapeGrammarBrain: ShapeGrammarBrain, didBuildShape shape: Shape) {
        shapeView?.addPathForShape(shape)
    }
    
}
