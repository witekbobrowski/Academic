import UIKit

class ProductsViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView?

    private var selectedIndex: Int?

    var category: Category?
    var products: [Product] = [] { didSet { tableView?.reloadData() } }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = category?.rawValue
        tableView?.backgroundColor = .clear
        tableView?.dataSource = self
        tableView?.delegate = self
        tableView?.reloadData()
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let detailsVC = segue.destination as? ProductDetailsViewController,
            let index = selectedIndex
            else { return }
        detailsVC.product = products[index]
    }

}

extension ProductsViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return products.isEmpty ? 0 : 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = .white
        cell.accessoryType = .disclosureIndicator
        let product = products[indexPath.row]
        cell.textLabel?.text = product.title
        return cell
    }

}

extension ProductsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "ProductDetailsViewController", sender: self)
    }

}
