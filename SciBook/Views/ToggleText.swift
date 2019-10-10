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
    @Binding var isOn: Bool
    
    //TODO: Using Color.clear because Color.systemBackground is not available. Also, using Text.tapAction instead of Button because it doesn't work well in a List.
    var body: some View {
        Text(label)
            .foregroundColor(isOn ? Color.white : .blue)
            .padding(.horizontal, 10)
            .background(isOn ? Color.blue : .clear)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue))
            .onTapGesture { self.isOn.toggle() }
    }
}

#if DEBUG
struct ToggleText_Previews : PreviewProvider {
    static var previews: some View {
        ToggleText(label: "Test1", isOn: .constant(true))
    }
}
#endif

