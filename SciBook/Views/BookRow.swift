//
//  BookRow.swift
//  SciBook
//
//  Created by Jake Foster on 7/11/19.
//  Copyright © 2019 Jake Foster. All rights reserved.
//

import SwiftUI

extension Award {
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

struct BookRow : View {
    let book: Book
    
    private var coverImage: Image {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .thin)
        return Image(uiImage: UIImage(systemName: "book", withConfiguration: imageConfig)!)
    }
    
    private func iconForAward(_ award: Award) -> some View {
        award.icon(enabled: book.hasAward(award))
    }

    var body: some View {
        HStack {
            coverImage
            VStack(alignment: .leading) {
                Text(book.title)
                    .font(.headline)
                Text("\(book.year) - \(book.authorName)")
                    .font(.subheadline)
                HStack(alignment: .center) {
                    iconForAward(.hugo)
                    iconForAward(.nebula)
                    iconForAward(.locus)
                }
            }
        }
    }
}

#if DEBUG
struct BookRow_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            BookRow(book: BookRepository.books[0])
            BookRow(book: BookRepository.books[1])
        }.previewLayout(.fixed(width: 300, height: 70))
    }
}
#endif
