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
    var isReadSelected = false {
        didSet {
            if isReadSelected {
                isUnreadSelected = false
            }
        }
    }
    var isUnreadSelected = false {
        didSet {
            if isUnreadSelected {
                isReadSelected = false
            }
        }
    }
    var isHugoSelected = false
    var isNebulaSelected = false
    var isLocusSelected = false
}

extension FilterState {
    static func selectedKeyPathFor(_ filter: Value) -> WritableKeyPath<FilterState, Bool> {
        switch filter {
        case .read:
            return \.isReadSelected
        case .unread:
            return \.isUnreadSelected
        case .hugo:
            return \.isHugoSelected
        case .nebula:
            return \.isNebulaSelected
        case .locus:
            return \.isLocusSelected
        }
    }

    func isSelected(_ filter: Value) -> Bool {
        return self[keyPath: Self.selectedKeyPathFor(filter)]
    }

    var selectedFilters: [Value] {
        Value.allCases.filter(isSelected)
    }
}
