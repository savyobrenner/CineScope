//
//  Codable+Extensions.swift
//  CineScope
//
//  Created by Savyo Brenner on 30/12/23.
//

import Foundation

extension Encodable {
    func asDictionary() -> [String: Any] {
        let serialized = (try? JSONSerialization.jsonObject(with: self.encode(), options: .allowFragments))
        return serialized as? [String: Any] ?? [String: Any]()
    }
    
    func encode() -> Data {
        return (try? JSONEncoder().encode(self)) ?? Data()
    }
}

extension Data {
    func asDictionary() -> [String: Any] {
        let serialized = try? JSONSerialization.jsonObject(with: self, options: [])
        return serialized as? [String: Any] ?? [:]
    }

    func decode<T: Codable>(_ object: T.Type) -> T? {
        do {
            return (try JSONDecoder().decode(T.self, from: self))
        } catch {
            debugPrint(error)
            return nil
        }
    }
}
