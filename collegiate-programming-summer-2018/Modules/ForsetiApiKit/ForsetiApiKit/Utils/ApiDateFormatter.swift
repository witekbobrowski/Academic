//
//  ApiDateFormatter.swift
//  ForsetiApiKit
//
//  Created by Witek Bobrowski on 23/05/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation

extension DateFormatter {

    static var apiDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZ"
        return formatter
    }

}
