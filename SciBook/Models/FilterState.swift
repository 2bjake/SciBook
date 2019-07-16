//
//  FilterState.swift
//  SciBook
//
//  Created by Jake Foster on 7/15/19.
//  Copyright © 2019 Jake Foster. All rights reserved.
//

import Foundation

struct FilterState {

    enum Value: CaseIterable {
        case read, unread, hugo, nebula, locus
    }

    var isEnabled = false
    var isReadSpecified = false {
        didSet {
            if isReadSpecified {
                isUnreadSpecified = false
            }
        }
    }
    var isUnreadSpecified = false {
        didSet {
            if isUnreadSpecified {
                isReadSpecified = false
            }
        }
    }
    var isHugoSpecified = false
    var isNebulaSpecified = false
    var isLocusSpecified = false
}

extension FilterState {
    static func propertyKeyPathFor(_ filter: Value) -> WritableKeyPath<FilterState, Bool> {
        switch filter {
        case .read:
            return \.isReadSpecified
        case .unread:
            return \.isUnreadSpecified
        case .hugo:
            return \.isHugoSpecified
        case .nebula:
            return \.isNebulaSpecified
        case .locus:
            return \.isLocusSpecified
        }
    }

    func isSpecified(_ filter: Value) -> Bool {
        return self[keyPath: Self.propertyKeyPathFor(filter)]
    }

    var specifiedFilters: [Value] {
        Value.allCases.filter(isSpecified)
    }
}
