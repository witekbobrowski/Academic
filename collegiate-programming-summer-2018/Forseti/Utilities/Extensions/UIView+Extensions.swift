//
//  UIView+Extensions.swift
//  Forseti
//
//  Created by Witek Bobrowski on 20/04/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import UIKit

extension UIView: Nameable {
    static var name: String {
        return String(describing: self)
    }
}
