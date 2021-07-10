//
//  LoginViewModel.swift
//  GoodNews
//
//  Created by Len van Zyl on 2021/07/10.
//

import Foundation
import RxSwift
import RxCocoa
class LoginViewModel{
    
    let userNameSubject = PublishSubject<String>()
    let passwordSubject = PublishSubject<String>()
    
    func isValid() -> Observable<Bool>{
        Observable.combineLatest(userNameSubject.asObserver().startWith(""), passwordSubject.asObserver().startWith("")).map { username, password in
            return username.count > 3 && password.count > 3
        }.startWith(false)
    }
}
