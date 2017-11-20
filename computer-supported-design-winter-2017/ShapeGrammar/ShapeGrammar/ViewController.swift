//
//  ViewController.swift
//  ShapeGrammar
//
//  Created by Witold Bobrowski on 24/10/2017.
//

import UIKit

class ViewController: UIViewController {

    private enum Constants {
        static let trianglePairHeightRatio: CGFloat = 2/3
        static let trianglePairOriginRatio: CGFloat = 1/3
    }
    
    @IBOutlet private weak var triangleContainerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    @objc private func backgroundDidTap(_ recognizer: UITapGestureRecognizer) {
        guard let triangleView = recognizer.view?.subviews.first as? TriangleView else { return }
        guard !triangleView.isUpsideDown else { return }
        let y = triangleView.bounds.height/2 - triangleView.height/2
        let triangle = TriangleView(frame: CGRect(x: triangleView.bounds.origin.x, y: y, width: triangleView.bounds.width, height: triangleView.bounds.height))
        triangleView.addSubview(triangle)
        triangle.isOpaque = false
        triangle.isUpsideDown = true
    }

}

//MARK: - Configuration
extension ViewController {
    
    private func configure() {
        let triangle = TriangleView(frame: CGRect(origin: triangleContainerView.bounds.origin, size: CGSize(width: triangleContainerView.bounds.width, height: triangleContainerView.bounds.height * Constants.trianglePairHeightRatio)))
        triangleContainerView.addSubview(triangle)
        triangle.isOpaque = false
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundDidTap(_:)))
        triangleContainerView.addGestureRecognizer(tapGesture)
    }
    
}
