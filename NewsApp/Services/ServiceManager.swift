//
//  ServiceManager.swift
//  NewsApp
//
//  Created by Mushfiq Humayoon on 26/05/22.
//

import UIKit

class ServiceManager {
    func loadJson(from url: String, completion: @escaping ([Article]) -> (Void))  {
        if let url = URL(string: url) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data, error == nil {
                    do {
                        let result = try JSONDecoder().decode(News.self, from: data)
                        completion(result.articles)
                    } catch let error {
                        print(error)
                    }
                }
            }.resume()
        }
    }
}
