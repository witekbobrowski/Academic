//
//  AccountNumberViewController.swift
//  Forseti
//
//  Created by Witek Bobrowski on 12/04/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import UIKit

class AccountNumberViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var profileButton: UIBarButtonItem!
    private weak var searchController: UISearchController?

    var viewModel: AccountNumberViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
        setupSearchController()
        setupNavigationBar()
    }

    @objc private func profileButtonDidTap( _ sender: UIBarButtonItem) {
        viewModel.profile()
    }

}

extension AccountNumberViewController {

    private func setupView() {
        navigationItem.title = viewModel.title
        profileButton.action = #selector(profileButtonDidTap(_:))
        profileButton.target = self
        profileButton.image = UIImage(named: viewModel.profileButtonAsset)
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

extension AccountNumberViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let accountNumber = searchBar.text else { return }
        viewModel.search(accountNumber)
    }

}

extension AccountNumberViewController: UITableViewDelegate {}
