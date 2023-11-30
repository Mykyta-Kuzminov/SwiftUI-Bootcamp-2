//
//  PostModel.swift
//  SwiftUI-Bootcamp-2
//
//  Created by Микита Кузьмінов on 29.11.2023.
//

import Foundation

struct PostModel: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
