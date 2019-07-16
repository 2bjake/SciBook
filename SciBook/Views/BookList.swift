//
//  BookList.swift
//  SciBook
//
//  Created by Jake Foster on 7/11/19.
//  Copyright © 2019 Jake Foster. All rights reserved.
//

import SwiftUI

private func awardRank(_ book: Book) -> Int {
    let awardsRanked = [Award.hugo, .nebula, .locus]
    
    for (rank, award) in awardsRanked.enumerated() {
        if book.hasAward(award) {
            return rank
        }
    }
    return awardsRanked.count
}

private func yearAwardSorter(a: Book, b: Book) -> Bool {
    if a.year == b.year {
        return awardRank(a) < awardRank(b)
    }
    return a.year > b.year
}

struct BookList : View {
    var body: some View {
        NavigationView {
            List {
                BookListFilter()
                ForEach(BookRepository.books.sorted(by: yearAwardSorter)) { book in
                    NavigationLink(destination: BookDetail(book: book)) {
                        BookRow(book: book)
                    }
                }
            }
        }
    }
}

#if DEBUG
struct BookList_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            BookList()
            BookList().colorScheme(.dark)
        }.previewDevice("iPhone 7")
    }
}
#endif
