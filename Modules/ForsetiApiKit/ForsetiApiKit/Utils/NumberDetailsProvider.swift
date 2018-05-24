//
//  NumberDetailsProvider.swift
//  ForsetiApiKit
//
//  Created by Witek Bobrowski on 24/05/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation

protocol NumberDetailsProvider {
    func numberDetails(forAccountNumber accountNumber: AccountNumber) -> AccountNumber?
}
