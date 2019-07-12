//
//  BookRepository.swift
//  SciBook
//
//  Created by Jake Foster on 7/11/19.
//  Copyright © 2019 Jake Foster. All rights reserved.
//

import Foundation

class BookRepository {

    static let books: [Book] = {
        BookRepository.load("books.json").compactMap{ $0.toBookModel() }
    }()

    private static func load(_ filename: String) -> [BookJSONModel] {
        let data: Data

        guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
            fatalError("Couldn't find \(filename) in main bundle.")
        }

        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }

        do {
            let decoder = JSONDecoder()
            return try decoder.decode([BookJSONModel].self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename):\n\(error)")
        }
    }
}
