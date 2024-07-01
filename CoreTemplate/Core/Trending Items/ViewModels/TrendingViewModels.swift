//
//  TrendingViewModels.swift
//  CoreTemplate
//
//  Created by Hualiteq International on 2024/6/29.
//
import Foundation
import Combine

class TrendingViewModels: ObservableObject, Identifiable {
    
    @Published var trendingOceanPosts: [ProductsPost] = []
    @Published var errorMessages: String? = nil
    
    init(){
        getTrendingPosts()
        print("DEBUG: Init called. TrendingOceanPosts: \(trendingOceanPosts), ErrorMessages: \(String(describing: errorMessages))")
    }
    
    func getTrendingPosts() {
        print("DEBUG: getTrendingPosts called.")
        
        NetworkManager.shared.getRequest(url: "/api/products") { (result: Result<[ProductsPost], Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let post):
                    self.trendingOceanPosts = post
                    print("DEBUG: Success. Received posts: \(post)")
                case .failure(let error):
                    self.errorMessages = error.localizedDescription
                    print("DEBUG: Error occurred: \(self.errorMessages ?? "Unknown error")")
                }
            }
        }
    }
}

    
    
    //    @Published var trendingPosts: [MyPosts] = []
    //    func getTrendingPosts() {
    //        NetworkManager.shared.getRequest(url: "/posts") { (result: Result<[MyPosts], Error>) in
    //            DispatchQueue.main.async {
    //                switch result {
    //                case .success(let posts):
    //                    self.trendingPosts = posts
    //                case .failure(let error):
    //                    self.errorMessages = error.localizedDescription
    //                }
    //            }
    //        }
    //    }
    
    

