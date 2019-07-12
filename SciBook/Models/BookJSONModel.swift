//
//  BookJSONModel.swift
//  SciBook
//
//  Created by Jake Foster on 7/11/19.
//  Copyright © 2019 Jake Foster. All rights reserved.
//

import Foundation

private let awardMap: [String: Award] = [
    "Hugo": .hugo,
    "Nebula": .nebula,
    "Locus": .locus
]

struct BookJSONModel: Codable {
    let id: Int
    let title: String
    let winner: [String]
    let year: String
    let publisher: String
    let author_first: String
    let author_last: String
}

extension BookJSONModel {
    func toBookModel() -> Book? {
        var awards = [Award: Bool]()
        winner.compactMap { awardMap[$0] }.forEach { awards[$0] = true }
        guard !awards.isEmpty else { return nil }
        let authorName = author_first + " " + author_last
        return Book(id: id, title: title, authorName: authorName, year: year, awards: awards)
    }
}
