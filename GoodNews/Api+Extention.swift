//
//  Api+Extention.swift
//  GoodNews
//
//  Created by Len van Zyl on 2021/07/10.
//

import Foundation
import RxCocoa
import RxSwift

struct Resource<T: Decodable>{
    let url: URL
}

extension URLRequest {
    static func load<T>(resource: Resource<T>) -> Observable<T?> {
        return Observable.from([resource.url]).flatMap { url -> Observable<Data> in
            let request = URLRequest(url: url)
            return URLSession.shared.rx.data(request: request)
        }.map { data -> T? in
            return try? JSONDecoder().decode(T.self, from: data)
        }.asObservable()
    }
}


