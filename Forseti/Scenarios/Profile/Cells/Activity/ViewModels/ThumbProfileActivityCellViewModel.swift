//
//  ThumbProfileActivityCellViewModel.swift
//  Forseti
//
//  Created by Witek Bobrowski on 15/05/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation
import ForsetiApiKit

class ThumbProfileActivityCellViewModel: ProfileActivityCellViewModel {

    private let thumbsDetails: ThumbsDetails
    private let accountNumber: String

    var title: String { return activityDescription() }
    var date: String { return thumbsDetails.timeStamp }

    init(thumbsDetails: ThumbsDetails, accountNumber: String) {
        self.thumbsDetails = thumbsDetails
        self.accountNumber = accountNumber
    }

}

extension ThumbProfileActivityCellViewModel {

    private func activityDescription() -> String {
        switch thumbsDetails.thumb {
        case .up:
            return "👍🏽 You have given thumbs up to account with number \(accountNumber)"
        case .down:
            return "👎🏽 You have given thumbs down to account with number \(accountNumber)"
        }
    }

}
