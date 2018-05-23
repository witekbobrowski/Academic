//
//  DateFormatter+Extensions.swift
//  Forseti
//
//  Created by Witek Bobrowski on 23/05/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation

extension DateFormatter {

    static var forsetiFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm d-MMMM-YYYY"
        return formatter
    }

}
