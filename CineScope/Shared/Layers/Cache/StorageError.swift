//
//  StorageError.swift
//  CineScope
//
//  Created by Savyo Brenner on 30/12/23.
//

import Foundation

public enum StorageError: Error {
    case notFound
    case cantWrite(Error)
    case cantDelete(StorageKey)
}


