//
//  ViewController.swift
//  ShapeGrammar
//
//  Created by Witold Bobrowski on 24/10/2017.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var starsContainerView: UIView!
    private var starsView: StarsView?
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
        let starsView = StarsView(frame: starsContainerView.bounds)
        starsContainerView.addSubview(starsView)
        starsView.isOpaque = false
        self.starsView = starsView
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundDidTap(_:)))
        view.addGestureRecognizer(tapGesture)
    }
    
}

extension ViewController: ShapeGrammarBrainDelegate {
    
    func shapeGrammarBrain(_ shapeGrammarBrain: ShapeGrammarBrain, didEndCalculatingShape shape: Shape) {
        //TODO: Redraw View with new shape
    }
    
}
