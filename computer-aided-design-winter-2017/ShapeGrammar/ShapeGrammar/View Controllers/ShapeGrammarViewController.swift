//
//  ShapeGrammarViewController.swift
//  ShapeGrammar
//
//  Created by Witold Bobrowski on 24/10/2017.
//

import UIKit

class ShapeGrammarViewController: UIViewController {
    
    
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var label: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var shapeContainerView: UIView!
    @IBOutlet private weak var randomButton: UIButton!
    @IBOutlet private weak var clearButton: UIButton!
    @IBOutlet private weak var mainContainerView: UIView!
    @IBOutlet private weak var samplesContainerView: UIView!
    private weak var samplesViewController: SamplesViewController?
    private weak var shapeView: ShapeView!
    private let gradient = CAGradientLayer()
    private let brain = ShapeGrammarBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureLabel()
        configureShapeView()
        configureButton()
        configureSamplesVC()
    }
    
    @objc private func backgroundDidTap(_ recognizer: UITapGestureRecognizer) {
        guard shapeContainerView.alpha == 1 else {
            brain.setup()
            toggleViews(descriptionShouldHide: true)
            return
        }
        guard let grammars = samplesViewController?.currentGeneration, !grammars.isEmpty else { return }
        brain.evolve(withGrammars: Array(grammars.prefix(3)))
    }

    @objc private func clearButtonDidTap(_ sender: UIButton) {
        clear()
        samplesViewController?.clear()
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
        scrollView.showsVerticalScrollIndicator = false
        scrollView.isPagingEnabled = true
        gradient.frame = view.layer.bounds
        view.layer.insertSublayer(gradient, at: 0)
        [mainContainerView, samplesContainerView].forEach { $0?.backgroundColor = .clear}
        gradient.colors = [UIColor(red: 182/255, green: 251/255, blue: 255/255, alpha: 1).cgColor, UIColor(red: 131/255, green: 164/255, blue: 212/255, alpha: 1).cgColor]
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundDidTap(_:)))
        mainContainerView.addGestureRecognizer(tapGesture)
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
    
    private func configureSamplesVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let samplesViewController = storyboard.instantiateViewController(withIdentifier: String(describing: SamplesViewController.self)) as! SamplesViewController
        addChildViewController(samplesViewController)
        samplesViewController.didMove(toParentViewController: self)
        samplesViewController.view.frame = samplesContainerView.bounds
        samplesViewController.title = "Samples"
        samplesViewController.delegate = self
        samplesContainerView.addSubview(samplesViewController.view)
        self.samplesViewController = samplesViewController
    }
    
    private func clear() {
        shapeView?.path = UIBezierPath()
        brain.clear()
    }
    
    private func toggleViews(descriptionShouldHide: Bool) {
        UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: [.calculationModeCubic], animations: {
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

    func shapeGrammarBrain(_ shapeGrammarBrain: ShapeGrammarBrain, didFinishGradingSamples samples: [(ShapeGrammar, Int)]) {
        samplesViewController?.insertGeneration(ofItems: samples)
    }
    
    func rectForDrawing(_ shapeGrammarBraint: ShapeGrammarBrain) -> CGRect? {
        return shapeView?.bounds
    }
    
    func shapeGrammarBrain(_ shapeGrammarBrain: ShapeGrammarBrain, didFinishBuildingGrammar grammar: ShapeGrammar) {
        shapeView.path = ShapeDrawingHelper.shared.getPathForGrammar(grammar)
    }
    
    func shapeGrammarBrain(_ shapeGrammarBrain: ShapeGrammarBrain, didFinishCalculatingScore score: Int) {
        print(score)
    }
    
}

//MARK: - SamplesViewControllerDelegate
extension ShapeGrammarViewController: SamplesViewControllerDelegate {
    
    func samplesViewController(_ samplesViewController: SamplesViewController, didPickGrammarsToCrossbreed grammars: [(grammar: ShapeGrammar, score: Int)]) {
        let prefix = Array(grammars.prefix(grammars.count/2))
        let suffix = Array(grammars.suffix(grammars.count/2))
        guard prefix.count == suffix.count else { return }
        let pairs = (0..<prefix.count).map { (a: prefix[$0], b: suffix[$0]) }
        let newGeneration = pairs
            .flatMap { ShapeCrossbreedingHelper.shared.crossbreed(a: $0.a.grammar, b: $0.b.grammar) }
            .map { (grammar: $0, score: ShapeGradingHelper.shared.getGrade(fromGrammar: $0.head)) }
        samplesViewController.insertGeneration(ofItems: newGeneration)
    }
    
}
