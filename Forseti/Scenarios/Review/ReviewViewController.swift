//
//  ReviewViewController.swift
//  Forseti
//
//  Created by Witek Bobrowski on 12/04/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    private weak var searchController: UISearchController?

    var viewModel: ReviewViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
        setupSearchController()
        setupNavigationBar()
    }

}

extension ReviewViewController {

    private func setupView() {
        navigationItem.title = viewModel.title
    }

    private func setupTableView() {
        tableView.backgroundColor = .clear
        tableView.delegate = self
//        tableView.dataSource = self
    }

    private func setupSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        self.searchController = searchController
    }

    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.2509803922, green: 0.2588235294, blue: 0.2549019608, alpha: 1)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }

}

extension ReviewViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let accountNumber = searchBar.text else { return }
        viewModel.search(accountNumber)
    }

}

extension ReviewViewController: UITableViewDelegate {}
