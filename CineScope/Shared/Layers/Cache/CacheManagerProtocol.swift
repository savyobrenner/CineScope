//
//  CacheManagerProtocol.swift
//  CineScope
//
//  Created by Savyo Brenner on 31/12/23.
//

import Foundation

public protocol CacheManagerProtocol {
    func fetch<T: Codable>(_ type: T.Type, for key: StorageKey) throws -> T
    func fetch<T: Codable>(_ type: T.Type, for key: String) throws -> T
    func save<T: Codable>(_ value: T, for key: StorageKey) throws
    func save<T: Codable>(_ value: T, for key: String) throws
    func remove<T: Codable>(type: T.Type, for key: StorageKey) throws
    func remove<T: Codable>(type: T.Type, for key: String) throws
}
