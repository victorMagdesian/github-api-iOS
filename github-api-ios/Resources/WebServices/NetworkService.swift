//
//  NetworkService.swift
//  github-api-ios
//
//  Created by ARYEL SANDER DOS SANTOS on 08/12/21.
//

import Foundation
import RxSwift
import UIKit

class NetworkService {
    func execute<T: Decodable>(url: URL) -> Observable<T> {
        return Observable.create { observer -> Disposable in
            var urlRequest = URLRequest(url: url)

            urlRequest.addValue(
                "token {TOKEN_AQUI}",
                forHTTPHeaderField: "Authorization")

            urlRequest.setValue(
                "application/json",
                forHTTPHeaderField: "Content-Type")

            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, let decoded = try? JSONDecoder().decode(T.self, from: data) else {
                    print("Response: \(String(describing: response)) \n\n\n")
                    print("error on converting data or decoded for \(type(of: T.self))")
                    print("\n\n\nError")
                    print(error.debugDescription)
                    return
                }
                observer.onNext(decoded)
                observer.onCompleted()
            }
            task.resume()

            return Disposables.create {
                task.cancel()
            }
        }
    }

    func execute(url: URL) -> Observable<String> {
        return Observable.create { observer -> Disposable in
            var urlRequest = URLRequest(url: url)

            urlRequest.addValue(
                "token {TOKEN_AQUI}",
                forHTTPHeaderField: "Authorization")

            urlRequest.addValue(
                "application/json",
                forHTTPHeaderField: "Content-Type"
            )

            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data else {
                    print("Response: \(String(describing: response)) \n\n\n")
                    print("\n\n\nError")
                    print(error.debugDescription)
                    return
                }
                let str = String(decoding: data, as: UTF8.self)
                observer.onNext(str)
                observer.onCompleted()
            }
            task.resume()

            return Disposables.create {
                task.cancel()
            }
        }
    }
}
