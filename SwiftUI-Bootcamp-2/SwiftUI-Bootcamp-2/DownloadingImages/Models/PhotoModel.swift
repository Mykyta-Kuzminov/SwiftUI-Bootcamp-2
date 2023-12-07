//
//  PhotoModel.swift
//  SwiftUI-Bootcamp-2
//
//  Created by Микита Кузьмінов on 07.12.2023.
//

import Foundation

struct PhotoModel: Identifiable, Codable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}
