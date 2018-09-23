import UIKit

class CategoryViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView?
    @IBOutlet weak var contactButton: UIBarButtonItem!

    private let dataProvider: DataProvider = MockedDataProvider()

    private var selectedIndex: Int?

    var categories: [Category] = [] { didSet { tableView?.reloadData() } }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Categories"
        contactButton.title = "Contact"
        tableView?.backgroundColor = .clear
        tableView?.dataSource = self
        tableView?.delegate = self
        tableView?.reloadData()
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        categories = dataProvider.categories()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let productsVC = segue.destination as? ProductsViewController,
            let index = selectedIndex
        else { return }
        let category = categories[index]
        productsVC.category = category
        productsVC.products = dataProvider.products(in: category)
    }

}

extension CategoryViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.isEmpty ? 0 : 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = .white
        cell.accessoryType = .disclosureIndicator
        let category = categories[indexPath.row]
        cell.textLabel?.text = category.rawValue
        return cell
    }

}

extension CategoryViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "ProductsViewController", sender: self)
    }

}
