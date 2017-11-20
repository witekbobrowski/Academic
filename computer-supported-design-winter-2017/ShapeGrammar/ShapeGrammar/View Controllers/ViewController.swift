//
//  ViewController.swift
//  ShapeGrammar
//
//  Created by Witold Bobrowski on 24/10/2017.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var shapeContainerView: UIView!
    private var shapeView: ShapeView?
    private let brain = ShapeGrammarBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    @objc private func backgroundDidTap(_ recognizer: UITapGestureRecognizer) {
        //TODO: Handle Tap
    }

}

//MARK: - Configuration
extension ViewController {
    
    private func configure() {
        let shapeView = ShapeView(frame: shapeContainerView.bounds)
        shapeContainerView.addSubview(shapeView)
        shapeView.isOpaque = false
        self.shapeView = shapeView
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundDidTap(_:)))
        view.addGestureRecognizer(tapGesture)
    }
    
}

//MARK: - ShapeGrammarBrainDelegate
extension ViewController: ShapeGrammarBrainDelegate {
    
    func shapeGrammarBrain(_ shapeGrammarBrain: ShapeGrammarBrain, didEndCalculatingShape shape: Shape) {
        shapeView?.addPathForShape(shape)
    }
    
}


