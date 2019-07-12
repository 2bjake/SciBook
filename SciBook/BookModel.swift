//
//  BookModel.swift
//  FirstNewBusinessLogic
//
//  Created by Foster, Jake on 5/29/19.
//  Copyright © 2019 Foster, Jake. All rights reserved.
//

import Foundation

struct BookJSONModel: Codable {
    let id: Int
    let title: String
    let winner: [String]
    let year: String
    let publisher: String
    let author_first: String
    let author_last: String
}

public struct BookModel {
    public enum Award { case hugo, nebula, locus, prometheus }

    public let title: String
    public let authorName: String
    public let year: Int
    public let awards: [Award]
}

private let awardMap: [String: BookModel.Award] = [
    "Hugo": .hugo,
    "Nebula": .nebula,
    "Locus": .locus
//    "Prometheus": .prometheus
]

extension BookJSONModel {
    func toBookModel() -> BookModel? {
        let awards = winner.compactMap { awardMap[$0] }
        guard !awards.isEmpty else { return nil }
        guard let year = Int(year) else { return nil}
        let authorName = author_first + " " + author_last
        return BookModel(title: title, authorName: authorName, year: year, awards: awards)
    }
}
