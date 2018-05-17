//
//  ProfileViewController.swift
//  Forseti
//
//  Created by Witek Bobrowski on 14/05/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var exitButton: UIBarButtonItem!

    var viewModel: ProfileViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
        setupNavigationBar()
    }

    @objc private func exitButtonDidTap(_ sender: UIBarButtonItem) {
        viewModel.exit()
    }

    @objc private func viewModelDidFinishFetching() {
        tableView.reloadData()
    }

}

extension ProfileViewController {

    private func setupView() {
        navigationItem.largeTitleDisplayMode = .automatic
        navigationItem.title = viewModel.title
        exitButton.action = #selector(exitButtonDidTap(_:))
        exitButton.target = self
        NotificationCenter.default.addObserver(self, selector: #selector(viewModelDidFinishFetching),
                                               name: .profileViewModelDidFetchUser, object: nil)
    }

    private func setupTableView() {
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 42
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        [ProfileOptionTableViewCell.self,
         ProfileActivityTableViewCell.self,
         ProfileAvatarTableViewCell.self].forEach { type in
            tableView.register(UINib(nibName: type.name, bundle: nil), forCellReuseIdentifier: type.name)
        }
    }

    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.2509803922, green: 0.2588235294, blue: 0.2549019608, alpha: 1)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }

}

extension ProfileViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath)
        (cell as? ProfileOptionTableViewCell)?.viewModel?.action()
        (cell as? ProfileActivityTableViewCell)?.viewModel?.action()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0: return 148
        case 1: return 42
        case 2: return 80
        default: return 0
        }
    }

}

extension ProfileViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(inSection: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        switch indexPath.section {
        case 0:
            let avatarCell = tableView.dequeueReusableCell(withIdentifier: ProfileAvatarTableViewCell.name, for: indexPath) as! ProfileAvatarTableViewCell
            avatarCell.viewModel = viewModel.avatarCellViewModel
            avatarCell.selectionStyle = .none
            cell = avatarCell
        case 1:
            let optionCell = tableView.dequeueReusableCell(withIdentifier: ProfileOptionTableViewCell.name, for: indexPath) as! ProfileOptionTableViewCell
            optionCell.viewModel = viewModel.viewModel(forOptionCellInRow: indexPath.row)
            cell = optionCell
        case 2:
            let activityCell = tableView.dequeueReusableCell(withIdentifier: ProfileActivityTableViewCell.name, for: indexPath) as! ProfileActivityTableViewCell
            activityCell.viewModel = viewModel.viewModel(forActivityCellInRow: indexPath.row)
            cell = activityCell
        default:
            cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.name, for: indexPath)
        }
        return cell
    }

}
