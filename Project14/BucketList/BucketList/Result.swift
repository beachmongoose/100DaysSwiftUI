//
//  Result.swift
//  BucketList
//
//  Created by Maggie Maldjian on 1/29/21.
//

import Foundation

struct Result: Codable {
  let query: Query
}

struct Query: Codable {
  let pages: [Int: Page]
}

struct Page: Codable {
  let pageid: Int
  let title: String
  let terms: [String: [String]]?
}
