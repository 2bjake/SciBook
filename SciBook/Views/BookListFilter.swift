//
//  BookListFilter.swift
//  SciBook
//
//  Created by Jake Foster on 7/15/19.
//  Copyright © 2019 Jake Foster. All rights reserved.
//

import SwiftUI

struct BookListFilter : View {
    @State var isFilterExpanded = false
    @State var filterState = FilterState()
    
    var isFilterEnabled: Bool {
        filterState.enabledFilters.isEmpty
    }
    
    // using image instead of button to avoid row flash
    var filterButton: some View {
            Image(systemName: isFilterEnabled ?  "line.horizontal.3.decrease.circle" : "line.horizontal.3.decrease.circle.fill")
                .foregroundColor(isFilterEnabled ? .primary : .blue)
                .imageScale(.large)
                .tapAction {
                    self.isFilterExpanded.toggle()
                }
    }

    var body: some View {
        Group {
            HStack {
                filterButton
                Spacer()
                if !filterState.summary.isEmpty {
                    VStack {
                        Text("Filtered by:")
                        Text(filterState.summary)
                            .foregroundColor(.blue)
                            .tapAction { self.isFilterExpanded.toggle() }
                    }.font(.caption)
                    Spacer()
                }
            }
            if isFilterExpanded {
                VStack(alignment: .leading) {
                    HStack {
                        ToggleText(label: Filter.read.rawValue, isOn: $filterState.isReadOn)
                        ToggleText(label: Filter.unread.rawValue, isOn: $filterState.isUnreadOn)
                    }
                    HStack {
                        ToggleText(label: Filter.hugo.rawValue, isOn: $filterState.isHugoOn)
                        ToggleText(label: Filter.nebula.rawValue, isOn: $filterState.isNebulaOn)
                        ToggleText(label: Filter.locus.rawValue, isOn: $filterState.isLocusOn)
                    }
                }
            }
        }
    }
}

#if DEBUG
struct BookListFilter_Previews : PreviewProvider {
    static var previews: some View {
        BookListFilter(isFilterExpanded: true)
    }
}
#endif
