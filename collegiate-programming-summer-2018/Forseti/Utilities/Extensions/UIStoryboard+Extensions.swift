//
//  UIStoryboard+Extensions.swift
//  Forseti
//
//  Created by Witek Bobrowski on 20/04/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import UIKit

extension UIStoryboard {

    func instantiateViewController<ViewController: UIViewController>(_ type: ViewController.Type ) -> ViewController {
        return instantiateViewController(withIdentifier: ViewController.name) as! ViewController
    }

}
