//
//  APIClient.swift
//  github-api-ios
//
//  Created by VICTOR FELIPPE MAGDESIAN on 06/12/21.
//

import Foundation
import UIKit

func apiClientFactory(urlParam: String) -> Data {
    var response: Data = Data()
    if let url = URL(string: urlParam) {
        if let data = try? Data(contentsOf: url) {
            response = data
        }
    }
    return response
}

func decode(_ data: Data) throws -> Repository? {
 let jsonDecode = JSONDecoder()

 do {
  let result = try jsonDecode.decode(Repository.self, from: data)
  return result

 } catch {
  print("Error")
 }

 return nil
}
