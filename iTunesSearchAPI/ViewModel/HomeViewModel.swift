//
//  HomeViewModel.swift
//  iTunesSearchAPI
//
//  Created by Yaz Burrell on 11/5/22.
//

import Foundation

extension HomeViewController {
    
    class HomeViewModel {
        // MARK: - Properties
        private var results: [Release] = []
        
        var albumCoverSize: CGSize = CGSize(width: 100, height: 100)
        
        var onReseultsReceived: (() -> Void)?
        
        var onError: ((String) -> Void)?
        
        // MARK: - API Actions
        
        func fetchResults(with query: String) {
            // Add API call here
            print("DEBUG: search not implemented")
        }
        
        func handleReleaseSection(at indexPath: IndexPath) {
            guard indexPath.row >= 0 && indexPath.row < results.count else { return }
            print("DEBUG: section not implemented")
        }
        
        // MARK: - API Data source
        
        func coverUrl(for indexPath: IndexPath) -> URL? {
            guard indexPath.row >= 0 && indexPath.row < results.count else { return nil }
            
            return results[indexPath.row].imageUrl
        }
        
        func numberOfResults() -> Int {
            results.count
        }
       
    }
    
}

extension HomeViewController.HomeViewModel {
    struct Release {
        var id: Int
        var imageUrl: URL
        var title: String
        var artistID: Int
    }
}
