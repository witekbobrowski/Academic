//
//  ProfileCoordinator.swift
//  Forseti
//
//  Created by Witek Bobrowski on 14/05/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import UIKit
import ForsetiApiKit
import SVProgressHUD

class ProfileCoordinator: Coordinator {

    private let coordinatorModel: ProfileCoordinatorModel
    private let viewControler: UIViewController?

    var next: Coordinator?
    weak var rootViewController: UIViewController?

    init(coordinatorModel: ProfileCoordinatorModel,
         viewControler: UIViewController?) {
        self.coordinatorModel = coordinatorModel
        self.viewControler = viewControler
    }

    func start() {
        let viewController = coordinatorModel.profileViewController
        viewController.viewModel.delegate = self
        let navigationController = UINavigationController(rootViewController: viewController)
        rootViewController = navigationController
        self.viewControler?.present(navigationController, animated: true)
    }

}

extension ProfileCoordinator: ProfileViewModelDelegate {

    func profileViewModelDidBeginFetchingUser(_ profileViewModel: ProfileViewModel) {
        print("\(type(of: profileViewModel)) did begin fetching user")
        SVProgressHUD.show()
    }

    func profileViewModel(_ profileViewModel: ProfileViewModel, didFinishFetchingUser user: User) {
        print("\(type(of: profileViewModel)) did finish fetching user: \(user.username)")
        SVProgressHUD.dismiss()
    }

    func profileViewModel(_ profileViewModel: ProfileViewModel, didFailFetchingWithError error: Error) {
        print("\(type(of: profileViewModel)) did fail fetching with error: \(error)")
        SVProgressHUD.showError(withStatus: nil)
        SVProgressHUD.dismiss(withDelay: 0.5) { [weak self] in
            self?.rootViewController?.dismiss(animated: true)
        }
    }

    func profileViewModelDidRequestExit(_ profileViewModel: ProfileViewModel) {
        print("\(type(of: profileViewModel)) did request exit!")
        rootViewController?.dismiss(animated: true)
    }

    func profileViewModelDidRequestSettings(_ profileViewModel: ProfileViewModel) {
        print("\(type(of: profileViewModel)) did request settings!")
    }

    func profileViewModelDidLogout(_ profileViewModel: ProfileViewModel) {
        print("\(type(of: profileViewModel)) did logout.")
        rootViewController?.dismiss(animated: true)
    }
}
