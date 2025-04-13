//
//  TagsModel.swift
//  MazaadyIOSTask
//
//  Created by Mac on 12/04/2025.
//


import Foundation


struct TagsResponse: Codable {
    let tags: [TagModel]
}

struct TagModel: Codable {
    let id: Int
    let name: String
}
