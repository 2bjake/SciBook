//
//  BookDetail.swift
//  SciBook
//
//  Created by Jake Foster on 7/11/19.
//  Copyright © 2019 Jake Foster. All rights reserved.
//

import SwiftUI

struct BookDetail : View {
    let book: Book
    
    var body: some View {
        Text("Hello World!")
    }
}

#if DEBUG
struct BookDetail_Previews : PreviewProvider {
    static var previews: some View {
        BookDetail(book: BookRepository.books[0])
    }
}
#endif
