//
//  AdsModel.swift
//  MazaadyIOSTask
//
//  Created by Mac on 12/04/2025.
//


import Foundation


struct AdsModel: Codable {
    let id: Int
    let image: String
}

struct AdvertisementsResponse: Codable {
    let advertisements: [AdsModel]
}
