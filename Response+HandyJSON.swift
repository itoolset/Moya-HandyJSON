//
//  Response+HandyJSON.swift
//  Response+HandyJSON
//
//  Created by leo on 2017/9/1.
//  Copyright © 2017年 leo. All rights reserved.
//

import Foundation

import Moya

import HandyJSON

import RxSwift

extension Response {
    func mapObject<T: HandyJSON>(_ type: T.Type) throws -> T {
        let jsonString = String(data: data, encoding: .utf8)
        guard let json = JSONDeserializer<T>.deserializeFrom(json: jsonString) else {
            throw MoyaError.stringMapping(self) // TODO:
        }
        
        return json
    }
}

extension ObservableType where E == Response {
    func mapObject<T: HandyJSON>(_ type: T.Type) -> Observable<T> {
        return flatMap({ Observable.just(try $0.mapObject(T.self)) })
    }
}

extension PrimitiveSequence where TraitType == SingleTrait, ElementType == Response {
    func mapObject<T: HandyJSON>(_ type: T.Type) -> Single<T> {
        return flatMap({ Single.just(try $0.mapObject(T.self)) })
    }
}
