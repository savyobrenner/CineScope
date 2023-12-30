//
//  CacheProtocol.swift
//  CineScope
//
//  Created by Savyo Brenner on 30/12/23.
//

import Foundation

public protocol ReadableStorage {
    func fetchValue<T: Codable>(for key: StorageKey) throws -> T
    func fetchValue<T: Codable>(for key: String) throws -> T
}

public protocol WritableStorage {
    func save<T: Codable>(value: T, for key: StorageKey) throws
    func save<T: Codable>(value: T, for key: String) throws
    func remove<T: Codable>(type: T.Type, for key: StorageKey) throws
    func remove<T: Codable>(type: T.Type, for key: String) throws
}

public typealias Storage = ReadableStorage & WritableStorage

