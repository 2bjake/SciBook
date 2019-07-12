//
//  BookRow.swift
//  SciBook
//
//  Created by Jake Foster on 7/11/19.
//  Copyright © 2019 Jake Foster. All rights reserved.
//

import SwiftUI

private struct AwardConfig: Identifiable {
    let award: Book.Award
    let hasAward: Bool
    
    var id: String { award.rawValue }

    var imageName: String {
        switch (award, hasAward) {
        case (.hugo, true):
            return "h.square.fill"
        case (.hugo, false):
            return "h.square"
        case (.nebula, true):
            return "n.square.fill"
        case (.nebula, false):
            return "n.square"
        case (.locus, true):
            return "l.square.fill"
        case (.locus, false):
            return "l.square"
        }
    }

    var color: Color {
        guard hasAward else { return .gray}
        switch award {
        case .hugo: return .red
        case .nebula: return .blue
        case .locus: return .green
        }
    }
}

struct BookRow : View {
    let book: Book
    
    private var image: Image {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .thin)
        return Image(uiImage: UIImage(systemName: "book", withConfiguration: imageConfig)!)
    }
    
    private var awardConfigs: [AwardConfig] {
        return [
            AwardConfig(award: .hugo, hasAward: book.hasAward(.hugo)),
            AwardConfig(award: .nebula, hasAward: book.hasAward(.nebula)),
            AwardConfig(award: .locus, hasAward: book.hasAward(.locus))
        ]
    }
    
    var body: some View {
        HStack {
            image
            VStack(alignment: .leading) {
                Text(book.title)
                    .font(.headline)
                Text("\(book.authorName) - \(book.year)")
                    .font(.subheadline)
                HStack(alignment: .center) {
                    ForEach(awardConfigs) { awardConfig in
                        Image(systemName: awardConfig.imageName)
                            .foregroundColor(awardConfig.color)
                    }
                }
            }
        }
    }
}

#if DEBUG
struct BookRow_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            BookRow(book: bookData[0])
            BookRow(book: bookData[1])
        }.previewLayout(.fixed(width: 300, height: 70))
    }
}
#endif
