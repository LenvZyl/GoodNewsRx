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

extension ArticleList {
    static var all: Resource<ArticleList> = {
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=" + Commons.apiKey)!
        return Resource(url: url)
    }()
}

extension URLRequest {
    static func load<T>(resource: Resource<T>) -> Observable<T?> {
        return Observable.from([resource.url]).flatMap { url -> Observable<Data> in
            let request = URLRequest(url: url)
            return URLSession.shared.rx.data(request: request)
        }.map { data -> T? in
            let articles = try? JSONDecoder().decode(T.self, from: data)
            return articles
        }.asObservable()
    }
}


