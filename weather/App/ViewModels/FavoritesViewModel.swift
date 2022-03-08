//
//  FavoritesViewModel.swift
//  weather
//
//  Created by Angad Singh Virk on 05/12/21.
//

import Foundation

@MainActor
class FavoritesViewModel: ObservableObject {
    @Published var favorites: [String]? = []
    static let shared = FavoritesViewModel()
    
    init() {
        fetchFavorites()
    }
    private func fetchFavorites() { // Fetch Favorites List from UserDefaults
        if (UserDefaults.standard.object(forKey: "favorites") != nil) {
            self.favorites = UserDefaults.standard.stringArray(forKey: "favorites")
        }
    }
}
