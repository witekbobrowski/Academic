//
//  AccountNumberViewController.swift
//  Forseti
//
//  Created by Witek Bobrowski on 12/04/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import UIKit

class AccountNumberViewController: UIViewController {

    enum State {
        case empty
        case filled
    }

    @IBOutlet private weak var emptyStateLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var profileButton: UIBarButtonItem!
    private weak var searchController: UISearchController?

    private var state: State = .empty { didSet { stateDidChange() } }

    var viewModel: AccountNumberViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
        setupSearchController()
        setupNavigationBar()
        stateDidChange()
    }

    @objc private func profileButtonDidTap( _ sender: UIBarButtonItem) {
        viewModel.profile()
    }

}

extension AccountNumberViewController {

    private func setupView() {
        navigationItem.title = viewModel.title
        emptyStateLabel.textColor = .lightGray
        emptyStateLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        emptyStateLabel.textAlignment = .center
        emptyStateLabel.numberOfLines = 0
        emptyStateLabel.text = viewModel.emptyState
        profileButton.action = #selector(profileButtonDidTap(_:))
        profileButton.target = self
        profileButton.image = UIImage(named: viewModel.profileButtonAsset)
    }

    private func setupTableView() {
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.separatorStyle = .none
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

    private func stateDidChange() {
        switch state {
        case .empty:
            tableView.backgroundColor = .clear
        case .filled:
            tableView.backgroundColor = .white
        }
    }

}

extension AccountNumberViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let accountNumber = searchBar.text else { return }
        viewModel.search(accountNumber)
    }

}

extension AccountNumberViewController: UITableViewDelegate {}
