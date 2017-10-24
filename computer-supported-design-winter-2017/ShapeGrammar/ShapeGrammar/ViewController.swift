//
//  ViewController.swift
//  ShapeGrammar
//
//  Created by Witold Bobrowski on 24/10/2017.
//

import UIKit

class ViewController: UIViewController {

    private var triangleView: TriangleView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

}

//MARK: - Configuration
extension ViewController {
    
    private func configure() {
        let triangle = TriangleView()
        view.addSubview(triangle)
        triangle.isOpaque = false
        triangle.frame = view.bounds
        triangleView = triangle
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundDidTap(_:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func backgroundDidTap(_ recogniser: UITapGestureRecognizer) {
        guard let isUpsideDown = triangleView?.isUpsideDown else {
            return
        }
        triangleView?.isUpsideDown = !isUpsideDown
    }
    
}
