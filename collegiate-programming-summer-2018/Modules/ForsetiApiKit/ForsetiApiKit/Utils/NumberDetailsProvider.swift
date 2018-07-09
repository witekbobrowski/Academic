//
//  NumberDetailsProvider.swift
//  ForsetiApiKit
//
//  Created by Witek Bobrowski on 24/05/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation

protocol NumberDetailsProvider {
    func numberDetails(forAccountNumber accountNumber: AccountNumber) -> NumberDetails?
}

class NumberDetailsProviderImplementation: NumberDetailsProvider {

    private let pathToNumberDetailsFile: URL
    private lazy var details: [String: NumberDetails] = parse(csvFileAtPath: pathToNumberDetailsFile,
                                                              ecoding: .utf8)

    init(pathToNumberDetailsFile: URL) {
        self.pathToNumberDetailsFile = pathToNumberDetailsFile
    }

    func numberDetails(forAccountNumber accountNumber: AccountNumber) -> NumberDetails? {
        let number = String(accountNumber.accountNumber.prefix(8))
        guard number.count == 8 else { return nil }
        return details[number]
    }

}

extension NumberDetailsProviderImplementation {

    private func parse(csvFileAtPath path: URL, ecoding: String.Encoding) -> [String: NumberDetails] {
        guard
            let file = try? Data(contentsOf: path),
            let contents = String(data: file, encoding: ecoding) else { return [:] }
        let lines = contents.split(separator: "\n")
        var results: [String: NumberDetails] = [:]
        for line in lines {
            let entry = line.split(separator: ",",
                                   maxSplits: 8,
                                   omittingEmptySubsequences: false).map { String($0) }
            results[entry[0]] = NumberDetails(sortCode: entry[0],
                                              bankName: entry[1],
                                              outpost: entry[2],
                                              address: entry[3],
                                              postal: fancyPostal(entry[4]),
                                              phone: entry[5],
                                              voivodeship: entry[6],
                                              district: entry[7])
        }
        return results
    }

    private func fancyPostal(_ postal: String) -> String {
        guard !postal.contains(" "), postal.count > 6 else { return postal }
        var fancy = postal
        fancy.insert(" ", at: fancy.index(fancy.startIndex, offsetBy: 6))
        return fancy
    }

}
