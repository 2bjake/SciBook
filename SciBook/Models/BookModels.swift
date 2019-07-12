//
//  BookModels.swift
//  SciBook
//
//  Created by Foster, Jake on 5/29/19.
//  Copyright © 2019 Foster, Jake. All rights reserved.
//

import SwiftUI

struct BookJSONModel: Codable {
    let id: Int
    let title: String
    let winner: [String]
    let year: String
    let publisher: String
    let author_first: String
    let author_last: String
}

public struct Book: Identifiable {
    public enum Award: String {
        case hugo = "Hugo"
        case nebula = "Nebula"
        case locus = "Locus"
    }

    public let id: Int
    public let title: String
    public let authorName: String
    public let year: String
    public let awards: [Award]
}

public extension Book {
    func hasAward(_ award: Award) -> Bool { awards.contains(award) }
}

private let awardMap: [String: Book.Award] = [
    "Hugo": .hugo,
    "Nebula": .nebula,
    "Locus": .locus
]

extension BookJSONModel {
    func toBookModel() -> Book? {
        let awards = winner.compactMap { awardMap[$0] }
        guard !awards.isEmpty else { return nil }
        let authorName = author_first + " " + author_last
        return Book(id: id, title: title, authorName: authorName, year: year, awards: awards)
    }
}
