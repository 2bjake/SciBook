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
    @Binding var filterState: FilterState

    var body: some View {
        Group {
            HStack {
                filterButton
                Spacer()
                if !filterStateSummary.isEmpty {
                    filterDescription
                    Spacer()
                }
            }
            if isExpanded {
                filterOptions
            }
        }
    }

    // using image instead of button to avoid row flash
    private var filterButton: some View {
            Image(systemName: filterState.isEnabled ?  "line.horizontal.3.decrease.circle.fill" : "line.horizontal.3.decrease.circle")
                .foregroundColor(.blue)
                .imageScale(.large)
                .onTapGesture(perform: filterButtonTap)
    }

    private func filterButtonTap() {
        filterState.isEnabled.toggle()

        if !filterState.isEnabled {
            isExpanded = false
        } else if filterState.selectedFilters.isEmpty {
            isExpanded = true
        }
    }

    private var filterDescription: some View {
        VStack {
            Text("Filtered by:")
            Text(filterStateSummary)
                .foregroundColor(.blue)
                .onTapGesture { self.isExpanded.toggle() }
        }.font(.caption)
    }

    //TODO: consider changing this to read like English
    //    Only showing books that are:
    //    Read
    //    Unread
    //    Hugo winners
    //    Hugo and Nebula winners
    //    Hugo, Nebula, and Locus winners
    //
    //    Read that are Hugo winners
    //    Unread that are Hugo, Nebula, and Locus winners
    private var filterStateSummary: String {
        guard filterState.isEnabled else { return "" }
        let filters = filterState.selectedFilters
        return filters.map(displayForFilter).joined(separator: ", ")
    }

    private func makeToggleTextFor(_ filter: FilterState.Value) -> ToggleText {
        ToggleText(label: displayForFilter(filter),
                   isOn: $filterState[dynamicMember: FilterState.selectedKeyPathFor(filter)])
    }

    private var filterOptions: some View {
        VStack(alignment: .leading) {
            HStack {
                makeToggleTextFor(.read)
                makeToggleTextFor(.unread)
            }
            Spacer()
            HStack {
                makeToggleTextFor(.hugo)
                makeToggleTextFor(.nebula)
                makeToggleTextFor(.locus)
            }
        }
    }
}

private func displayForFilter(_ filter: FilterState.Value) -> String {
    switch filter {
    case .read: return "Read"
    case .unread: return "Unread"
    case .hugo: return "Hugo"
    case .nebula: return "Nebula"
    case .locus: return "Locus"
    }
}

#if DEBUG
struct BookListFilter_Previews : PreviewProvider {
    static var state = FilterState()

    static var previews: some View {
        BookListFilter(filterState: Binding<FilterState>(get: { Self.state }, set: { Self.state = $0 }))
    }
}
#endif

