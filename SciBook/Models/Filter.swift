//
//  Filter.swift
//  SciBook
//
//  Created by Jake Foster on 7/15/19.
//  Copyright © 2019 Jake Foster. All rights reserved.
//

import Foundation

enum Filter: String, CaseIterable {
    case read = "Read"
    case unread = "Unread"
    case hugo = "Hugo"
    case nebula = "Nebula"
    case locus = "Locus"
}

struct FilterState {
    var isReadOn = false
    var isUnreadOn = false
    var isHugoOn = false
    var isNebulaOn = false
    var isLocusOn = false
}

extension FilterState {
    func isOn(_ filter: Filter) -> Bool {
        switch filter {
        case .read:
            return isReadOn
        case .unread:
            return isUnreadOn
        case .hugo:
            return isHugoOn
        case .nebula:
            return isNebulaOn
        case .locus:
            return isLocusOn
        }
    } 

    var enabledFilters: [Filter] {
        Filter.allCases.filter { isOn($0) }
    }

    mutating func clear() {
        self = FilterState()
    }

    var summary: String {
        let filters = enabledFilters
        guard !filters.isEmpty else { return "" }
        return filters.map { $0.rawValue }.joined(separator: ", ")
    }
}
