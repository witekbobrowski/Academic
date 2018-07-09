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

    enum Section: Int {
        case details
        case actions
        case comments
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

    @objc private func viewModelDidFinishFetching() {
        state = .filled
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
        NotificationCenter.default.addObserver(self, selector: #selector(viewModelDidFinishFetching),
                                               name: .accountNumberViewModelDidFindAccount, object: nil)
    }

    private func setupTableView() {
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
        [AccountNumberDetailsTableViewCell.self,
         AccountNumberActionTableViewCell.self,
         AccountNumberCommentTableViewCell.self].forEach { type in
            tableView.register(UINib(nibName: type.name, bundle: nil), forCellReuseIdentifier: type.name)
        }
    }

    private func setupSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.searchBar.showsCancelButton = true
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
            searchController?.dismiss(animated: true)
            tableView.backgroundColor = .white
            tableView.reloadData()
        }
    }

}

extension AccountNumberViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let accountNumber = searchBar.text else { return }
        viewModel.search(accountNumber)
    }

}

extension AccountNumberViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(inSection: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        switch Section(rawValue: indexPath.section)! {
        case .details:
            let detailsCell = tableView.dequeueReusableCell(
                withIdentifier: AccountNumberDetailsTableViewCell.name,
                for: indexPath) as! AccountNumberDetailsTableViewCell
            detailsCell.viewModel = viewModel.detailsCellViewModel()
            cell = detailsCell
        case .actions:
            let actionsCell = tableView.dequeueReusableCell(
                withIdentifier: AccountNumberActionTableViewCell.name,
                for: indexPath) as! AccountNumberActionTableViewCell
            actionsCell.viewModel = viewModel.actionsCellViewModel()
            cell = actionsCell
        case .comments:
            let commentCell = tableView.dequeueReusableCell(
                withIdentifier: AccountNumberCommentTableViewCell.name,
                for: indexPath) as! AccountNumberCommentTableViewCell
            commentCell.viewModel = viewModel.commentCellViewModel(forCellAt: indexPath.row)
            cell = commentCell
        }
        cell.selectionStyle = .none
        return cell
    }

}
