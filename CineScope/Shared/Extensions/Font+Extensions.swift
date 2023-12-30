//
//  Font+Extensions.swift
//  CineScope
//
//  Created by Savyo Brenner on 30/12/23.
//

import SwiftUI

extension Font {
    
    static func brand(_ name: BrandFontName = .regular, size: CGFloat = 16, relativeTo: TextStyle = .body) -> Font {
        .custom(name.rawValue, size: size, relativeTo: relativeTo)
    }
}
