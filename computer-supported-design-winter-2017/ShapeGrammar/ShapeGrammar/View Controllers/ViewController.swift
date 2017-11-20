//
//  ViewController.swift
//  ShapeGrammar
//
//  Created by Witold Bobrowski on 24/10/2017.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var label: UILabel!
    @IBOutlet private weak var labelContainerView: UIView!
    @IBOutlet private weak var shapeContainerView: UIView!
    private var shapeView: ShapeView?
    private let brain = ShapeGrammarBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureLabel()
        configureShapeView()
    }
    
    @objc private func backgroundDidTap(_ recognizer: UITapGestureRecognizer) {
        //TODO: Handle Tap
    }

}

//MARK: - Configuration
extension ViewController {
    
    private func configure() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundDidTap(_:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func configureLabel() {
        label.text = "ShapeGrammar"
        label.textColor = UIColor(red: 66/255, green: 66/255, blue: 66/255, alpha: 1)
        label.textAlignment = .center
    }
    
    private func configureShapeView() {
        let shapeView = ShapeView(frame: shapeContainerView.bounds)
        shapeContainerView.addSubview(shapeView)
        shapeView.isOpaque = false
        self.shapeView = shapeView
    }
    
}

//MARK: - ShapeGrammarBrainDelegate
extension ViewController: ShapeGrammarBrainDelegate {
    
    func shapeGrammarBrain(_ shapeGrammarBrain: ShapeGrammarBrain, didEndCalculatingShape shape: Shape) {
        shapeView?.addPathForShape(shape)
    }
    
}


