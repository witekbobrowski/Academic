import UIKit
import Kingfisher

class ProductDetailsViewController: UIViewController {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var learnMoreButton: UIButton!

    var product: Product?

    override func viewDidLoad() {
        super.viewDidLoad()
        learnMoreButton.setTitle("Learn more", for: .normal)
        update(with: product)
    }

    @IBAction func learnMoreButtonDidTap(_ sender: UIButton) {
        guard let product = product, let url = URL(string: product.discoverURL) else { return }
        UIApplication.shared.open(url)
    }

    private func update(with product: Product?) {
        guard let product = product else { return }
        navigationItem.title = product.title
        titleLabel.text = product.title
        priceLabel.text = "Starting at $\(product.startingPrice)"
        descriptionLabel.text = product.description
        imageView.kf.setImage(with: URL(string: product.imageURL))
        imageView.kf.indicatorType = .activity
    }

}
