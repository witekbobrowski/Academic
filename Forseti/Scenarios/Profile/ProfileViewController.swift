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
    private weak var tableHeaderView: ProfileTableHeaderView?

    var viewModel: ProfileViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
        setupTableHeaderView()
        setupNavigationBar()
    }

    @objc private func exitButtonDidTap(_ sender: UIBarButtonItem) {
        viewModel.exit()
    }

}

extension ProfileViewController {

    private func setupView() {
        navigationItem.title = viewModel.title
        exitButton.action = #selector(exitButtonDidTap(_:))
        exitButton.target = self
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        [ProfileOptionTableViewCell.self, ProfileActivityTableViewCell.self].forEach { type in
            tableView.register(UINib(nibName: type.name, bundle: nil), forCellReuseIdentifier: type.name)
        }
    }

    private func setupTableHeaderView() {
        let bundle = Bundle(for: self.classForCoder)
        let tableHeaderView = bundle.loadNibNamed(ProfileTableHeaderView.name,
                                                  owner: nil,
                                                  options: nil)?.first as! ProfileTableHeaderView
        tableHeaderView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableHeaderView = tableHeaderView
        tableHeaderView.widthAnchor.constraint(equalTo: tableView.widthAnchor, multiplier: 1).isActive = true
        tableHeaderView.heightAnchor.constraint(equalToConstant: 185).isActive = true
        self.tableHeaderView = tableHeaderView
    }

    private func setupNavigationBar() {
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.2509803922, green: 0.2588235294, blue: 0.2549019608, alpha: 1)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }

}

extension ProfileViewController: UITableViewDelegate {}

extension ProfileViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(inSection: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: UITableViewCell.name, for: indexPath)
    }

}
