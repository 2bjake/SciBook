//
//  ToggleText.swift
//  SciBook
//
//  Created by Jake Foster on 7/15/19.
//  Copyright © 2019 Jake Foster. All rights reserved.
//

import SwiftUI

struct ToggleText : View {
    let label: String
    let isOn: Binding<Bool>
    

    //TODO: Using Color.clear because Color.systemBackground is not available. Also, using Text.tapAction instead of Button because it doesn't work well in a List.
    var body: some View {
        Text(label)
            .foregroundColor(isOn.value ? Color.white : .primary)
            .padding(.horizontal, 10)
            .background(isOn.value ? Color.blue : .clear)
            .cornerRadius(10)
            .border(isOn.value ? Color.blue : .primary, cornerRadius: 10)
            .tapAction { self.isOn.value.toggle() }
    }
}

#if DEBUG
struct SwiftUIView_Previews : PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
#endif
