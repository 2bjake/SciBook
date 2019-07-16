//
//  FilterState.swift
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
    var isReadSpecified = false
    var isUnreadSpecified = false
    var isHugoSpecified = false
    var isNebulaSpecified = false
    var isLocusSpecified = false
}

extension FilterState {
    func isSpecified(_ filter: Filter) -> Bool {
        switch filter {
        case .read:
            return isReadSpecified
        case .unread:
            return isUnreadSpecified
        case .hugo:
            return isHugoSpecified
        case .nebula:
            return isNebulaSpecified
        case .locus:
            return isLocusSpecified
        }
    } 

    var specifiedFilters: [Filter] {
        Filter.allCases.filter { isSpecified($0) }
    }

    mutating func clear() {
        self = FilterState()
    }

    var summary: String {
        let filters = specifiedFilters
        guard !filters.isEmpty else { return "" }
        return filters.map { $0.rawValue }.joined(separator: ", ")
    }
}
