//
//  FactModel.swift
//  Useless Facts
//
//  Created by Sam Hoag on 2/9/24.
//

import Foundation

struct Fact: Codable {
    let id: String
    let text: String
    let source: String
    let source_url: String
    let language: String
    let permalink: String
}
