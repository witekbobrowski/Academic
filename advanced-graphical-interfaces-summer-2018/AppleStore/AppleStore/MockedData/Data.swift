import Foundation

protocol DataProvider {
    func categories() -> [Category]
    func products(in category: Category?) -> [Product]
}

class MockedDataProvider: DataProvider {

    private var _products: [Product] = []
    private var _categories: [Category] = []

    init() {
        loadData()
    }

    func categories() -> [Category] {
        return _categories
    }

    func products(in category: Category?) -> [Product] {
        guard let category = category else { return _products }
        return _products.filter { $0.category == category }
    }

    private func loadData() {
        let productsFilePath = Bundle.main.url(forResource: "Products",
                                               withExtension: "json")!
        let categoriesFilePath = Bundle.main.url(forResource: "Categories",
                                               withExtension: "json")!
        let productsData = try! Data(contentsOf: productsFilePath)
        let categoriesData = try! Data(contentsOf: categoriesFilePath)
        _products = try! JSONDecoder().decode(Array<Product>.self,
                                              from: productsData)
        _categories = try! JSONDecoder().decode(Array<Category>.self,
                                                from: categoriesData)
    }

}
