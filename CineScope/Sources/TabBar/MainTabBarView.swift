//
//  MainTabBarView.swift
//  CineScope
//
//  Created by Savyo Brenner on 31/12/23.
//

import Foundation

struct MainTabBarView: View {
    
    @State var selectedTab = 0
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                
            }
        }
    }
}
