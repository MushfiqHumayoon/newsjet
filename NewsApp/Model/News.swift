//
//  News.swift
//  NewsApp
//
//  Created by Mushfiq Humayoon on 26/05/22.
//

import UIKit

struct News: Decodable {
    let articles: [Article]
}
struct Article: Decodable {
    let author: String
    let title: String
    let description: String
    let url: String
    let urlToImage: String
    let publishedAt: String
    let content: String
}
