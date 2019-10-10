//
//  AwardIcons.swift
//  SciBook
//
//  Created by Jake Foster on 8/2/19.
//  Copyright © 2019 Jake Foster. All rights reserved.
//

import SwiftUI

struct AwardIcons: View {
    let book: Book

    var body: some View {
        HStack(alignment: .center) {
            iconForAward(.hugo)
            iconForAward(.nebula)
            iconForAward(.locus)
        }
    }

    private func iconForAward(_ award: Award) -> some View {
        award.icon(enabled: book.hasAward(award))
    }
}

private extension Award {
    func icon(enabled: Bool) -> some View {
        let color: Color = {
            switch (enabled, self) {
            case (false, _): return .gray
            case (true, .hugo): return .red
            case (true, .nebula): return .blue
            case (true, .locus): return .green
            }
        }()

        var imageName: String = {
            switch self {
            case .hugo: return "h.square"
            case .nebula: return "n.square"
            case .locus: return "l.square"
            }
        }()

        if enabled {
            imageName += ".fill"
        }
        return Image(systemName: imageName)
            .foregroundColor(color)
    }
}

#if DEBUG
struct AwardIcons_Previews: PreviewProvider {
    static var previews: some View {
        AwardIcons(book: BookRepository.books[0])
    }
}
#endif
