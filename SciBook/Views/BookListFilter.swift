//
//  BookListFilter.swift
//  SciBook
//
//  Created by Jake Foster on 7/15/19.
//  Copyright © 2019 Jake Foster. All rights reserved.
//

import SwiftUI

struct BookListFilter : View {
    @State var isEnabled = false
    @State var isExpanded = false
    @State var filterState = FilterState()

    private func onButtonTap() {
        isEnabled.toggle()

        if !isEnabled {
            isExpanded = false
        } else if isEnabled && filterState.specifiedFilters.isEmpty {
            isExpanded = true
        }
    }

    // using image instead of button to avoid row flash
    var filterButton: some View {
            Image(systemName: isEnabled ?  "line.horizontal.3.decrease.circle.fill" : "line.horizontal.3.decrease.circle")
                .foregroundColor(isEnabled ? .blue : .primary)
                .imageScale(.large)
                .tapAction(onButtonTap)
    }

    var body: some View {
        Group {
            HStack {
                filterButton
                Spacer()
                if isEnabled && !filterState.specifiedFilters.isEmpty {
                    VStack {
                        Text("Filtered by:")
                        Text(filterState.summary)
                            .foregroundColor(.blue)
                            .tapAction { self.isExpanded.toggle() }
                    }.font(.caption)
                    Spacer()
                }
            }
            if isExpanded {
                VStack(alignment: .leading) {
                    HStack {
                        ToggleText(label: Filter.read.rawValue, isOn: $filterState.isReadSpecified)
                        ToggleText(label: Filter.unread.rawValue, isOn: $filterState.isUnreadSpecified)
                    }
                    HStack {
                        ToggleText(label: Filter.hugo.rawValue, isOn: $filterState.isHugoSpecified)
                        ToggleText(label: Filter.nebula.rawValue, isOn: $filterState.isNebulaSpecified)
                        ToggleText(label: Filter.locus.rawValue, isOn: $filterState.isLocusSpecified)
                    }
                }
            }
        }
    }
}

#if DEBUG
struct BookListFilter_Previews : PreviewProvider {
    static var previews: some View {
        BookListFilter(isExpanded: true)
    }
}
#endif
