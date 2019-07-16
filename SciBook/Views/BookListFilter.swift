//
//  BookListFilter.swift
//  SciBook
//
//  Created by Jake Foster on 7/15/19.
//  Copyright © 2019 Jake Foster. All rights reserved.
//

import SwiftUI

struct BookListFilter : View {
    @State var isExpanded = false
    var filterState: Binding<FilterState>

    private func onButtonTap() {
        filterState.value.isEnabled.toggle()

        if !filterState.value.isEnabled {
            isExpanded = false
        } else if filterState.value.specifiedFilters.isEmpty {
            isExpanded = true
        }
    }

    // using image instead of button to avoid row flash
    var filterButton: some View {
            Image(systemName: filterState.value.isEnabled ?  "line.horizontal.3.decrease.circle.fill" : "line.horizontal.3.decrease.circle")
                .foregroundColor(filterState.value.isEnabled ? .blue : .primary)
                .imageScale(.large)
                .tapAction(onButtonTap)
    }

    var filterDescription: some View {
        VStack {
            Text("Filtered by:")
            Text(filterState.value.summary)
                .foregroundColor(.blue)
                .tapAction { self.isExpanded.toggle() }
        }.font(.caption)
    }

    var body: some View {
        Group {
            HStack {
                filterButton
                Spacer()
                if !filterState.value.summary.isEmpty {
                    filterDescription
                    Spacer()
                }
            }
            if isExpanded {
                VStack(alignment: .leading) {
                    HStack {
                        ToggleText(label: Filter.read.rawValue, isOn: filterState.binding.isReadSpecified)
                        ToggleText(label: Filter.unread.rawValue, isOn: filterState.binding.isUnreadSpecified)
                    }
                    HStack {
                        ToggleText(label: Filter.hugo.rawValue, isOn: filterState.binding.isHugoSpecified)
                        ToggleText(label: Filter.nebula.rawValue, isOn: filterState.binding.isNebulaSpecified)
                        ToggleText(label: Filter.locus.rawValue, isOn: filterState.binding.isLocusSpecified)
                    }
                }
            }
        }
    }
}
