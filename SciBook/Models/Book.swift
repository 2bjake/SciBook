//
//  BookModels.swift
//  SciBook
//
//  Created by Foster, Jake on 5/29/19.
//  Copyright © 2019 Foster, Jake. All rights reserved.
//

import SwiftUI

public struct Book: Identifiable {
    public let id: Int
    public let title: String
    public let authorName: String
    public let year: String
    public let awards: [Award: Bool]
}

// TODO: make this real
extension Book {
    public var isRead: Bool { Bool.random() }
}

public extension Book {
    func hasAward(_ award: Award) -> Bool { awards[award] ?? false }
}
