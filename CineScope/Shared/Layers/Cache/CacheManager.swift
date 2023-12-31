//
//  CacheManager.swift
//  CineScope
//
//  Created by Savyo Brenner on 30/12/23.
//

import Foundation

public final class CacheManager: CacheManagerProtocol {
    private let decoder: JSONDecoder
    private let encoder: JSONEncoder
    private lazy var userDefaultsStorage = UserDefaultsStorage()
    
    init(decoder: JSONDecoder = .init(),
         encoder: JSONEncoder = .init()) {
        self.decoder = decoder
        self.encoder = encoder
    }
    
    public func fetch<T: Codable>(_ type: T.Type, for key: StorageKey) throws -> T {
        return try getSuitableStorage().fetchValue(for: key)
    }
    
    public func fetch<T: Codable>(_ type: T.Type, for key: String) throws -> T {
        return try getSuitableStorage().fetchValue(for: key)
    }
    
    public func save<T: Codable>(_ value: T, for key: StorageKey) throws {
        try getSuitableStorage().save(value: value, for: key)
    }
    
    public func save<T: Codable>(_ value: T, for key: String) throws {
        try getSuitableStorage().save(value: value, for: key)
    }
    
    public func remove<T: Codable>(type: T.Type, for key: StorageKey) throws {
        try getSuitableStorage().remove(type: type, for: key)
    }
    
    public func remove<T: Codable>(type: T.Type, for key: String) throws {
        try getSuitableStorage().remove(type: type, for: key)
    }
}

private extension CacheManager {
    func getSuitableStorage() -> Storage {
        return userDefaultsStorage
    }
}
