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
    @State var filterState = FilterState()

    var filteredSortedBooks: [Book] {
        BookRepository.books.filter { book in
            guard filterState.isEnabled else { return true }

            for filter in filterState.specifiedFilters {
                switch filter {
                case .read:
                    if !book.isRead { return false }
                case .unread:
                    if book.isRead { return false }
                case .hugo:
                    if !book.hasAward(.hugo) { return false }
                case .nebula:
                    if !book.hasAward(.nebula) { return false }
                case .locus:
                    if !book.hasAward(.locus) { return false }
                }
            }
            return true
        }.sorted(by: yearAwardSorter)
    }

    var body: some View {
        NavigationView {
            List {
                BookListFilter(filterState: $filterState)
                ForEach(filteredSortedBooks) { book in
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
