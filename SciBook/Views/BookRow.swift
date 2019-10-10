//
//  BookRow.swift
//  SciBook
//
//  Created by Jake Foster on 7/11/19.
//  Copyright © 2019 Jake Foster. All rights reserved.
//

import SwiftUI

struct BookRow : View {
    let book: Book

    var body: some View {
        HStack {
            coverImage
            VStack(alignment: .leading) {
                Text(book.title)
                    .font(.headline)
                Text("\(book.year) - \(book.authorName)")
                    .font(.subheadline)
                AwardIcons(book: book)
            }

            if book.isRead {
                Spacer()
                readIcon()
            }
        }
    }
    
    private var coverImage: some View {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .thin)
        //TODO: "book" is just a placeholder image
        return Image(uiImage: UIImage(systemName: "book", withConfiguration: imageConfig)!)
    }

    private func readIcon() -> some View {
        return Image(systemName: "checkmark.circle.fill")
            .imageScale(.large)
            .foregroundColor(.green)
    }
}

#if DEBUG
struct BookRow_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            BookRow(book: BookRepository.books[0])
            BookRow(book: BookRepository.books[1])
        }
    }
}
#endif
