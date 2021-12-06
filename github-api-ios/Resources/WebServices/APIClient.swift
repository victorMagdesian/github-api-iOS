//
//  APIClient.swift
//  github-api-ios
//
//  Created by VICTOR FELIPPE MAGDESIAN on 06/12/21.
//

import Foundation
import UIKit

func apiClientFactory(url: String) -> String {
    var response = ""
    if let url = URL(string: url) {
        URLSession.shared.dataTask(with: url) {data, res, error in
            if let data = data {
                do {
                    let res = String(data: data, encoding: .utf8)
                    response = res!
                } catch let error {
                    response = "\(error)"
                }
            }

        }.resume()
    }
    return response
}
