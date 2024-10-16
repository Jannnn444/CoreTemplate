//
//  ExploreView.swift
//  CoreTemplate
//
//  Created by Hualiteq International on 2024/9/2.
//

import SwiftUI

struct ExploreView: View {
    
    @State var nav: NavState = .Explore
    @State var movieList: [MovieRender] = []
    
    let columns = Array(repeating: GridItem( spacing: 0, alignment: .center), count: 2)
    
    var movieData: [Movie] = [
        Movie(title: "Bone Tomahawh", sexy: true, ratings: 4.3),
        Movie(title: "Cars", sexy: false, ratings: 3.1),
        Movie(title: "Inception", sexy: true, ratings: 1.7)
    ]
    
    // example from API
    struct Movie: Identifiable  { // hashable gives random id
        var id = UUID() // automatically trackable
        var title: String
        var sexy: Bool
        var ratings: Double //4.6
    }
    
    struct MovieRender: Identifiable  { // hashable gives random id
        var id = UUID() // automatically trackable
        var title: String
        var sexy: Bool
        var ratings: [Int]  //array!!
    }
    
    
    var body: some View {
            ZStack{
                ScrollView {
                Text("Store Catalogs")
                    .padding()
                    .font(.title)
                    .foregroundStyle(Color.black)
  
                    // MARK: LazyGrid 3 - AsyncImage
                    LazyVGrid(columns: columns, spacing: 5) {
                        ForEach(0..<12, id: \.self) { index in
                            Group{
                                VStack {
                                    AsyncImage(url: URL(string: "https://picsum.photos/600"))
                                        .scaledToFit()
                                        .frame(width: 150, height: 160)
                                        .cornerRadius(5)
                                    Text("Item name : ")
                                        .font(.body)
                                        .foregroundStyle(Color.black)
                                    
                                    HStack {
                                        Text("Ratings: ")
                                        ForEach(movieList) { movie in
                                            
                                            //   this for displaying stars
                                            //   [0,0,0,1]
                                            
                                            ForEach(movie.ratings, id: \.self) { number in
                                                if number == 0 {
                                                    Image(systemName: "star.fill")
                                                } else if number == 1 {
                                                    ZStack {
                                                        Image(systemName: "star.fill")
                                                            .clipShape(Rectangle().size(width: 10, height: 20))
                                                    }
                                                } else {
                                                    Image(systemName: "star")
                                                }
                                            }
                                        }
                                    }
                                }.padding()
                            }
                    }.onAppear {
                        print("MovieData: \(movieData)")
                        let formattedMovieList = movieData.map { movie in
                            //eaach movie 1 by 1
                            
                            MovieRender(
                                title: movie.title, sexy: movie.sexy,
                                ratings: checkClosestNumberToShowStars(ratingNum: movie.ratings))
                        }
                        self.movieList = formattedMovieList
                    }
                 
                }
                    Text("Happy doggo shop.co")
                        .padding()
                        .font(.body)
                        .foregroundStyle(Color.black)
            }
            .padding()
            } .onAppear {
                print("movieData: \(movieData)")
                
                // set up movie list
                let formattedMovieList = movieData.map { movie in
                    //eaach movie 1 by 1
                    
                    MovieRender(
                        title: movie.title, sexy: movie.sexy,
                        ratings: checkClosestNumberToShowStars(ratingNum: movie.ratings))
                }
                self.movieList = formattedMovieList
            }
    }
    
    
    func checkClosestNumberToShowStars(ratingNum: Double) -> [Int] {
        
        let starTiersArray = [1.0, 1.5, 2.0, 2.5, 3.0, 3.5, 4.0, 4.5, 5.0]
        var cloestTier: Double = 0.0
        var smallestDifference: Double = 6.0
        var starArray:[Int] = []
        
        // NOW:
        // 4.5 -> [0.0.0.0] -> 4 stars Images
        
        for item in starTiersArray {
            // if rating = 2, diff = [1, 0.5, 0, 0.5, 1, 1.5, 2, 2.5]
            
            let diff = abs(item - ratingNum)  // this abs() will no minus
            
            if diff < smallestDifference {
                smallestDifference = diff // give the destination updated value
                cloestTier = item
                // ！Update the cloest tier when a small difference is found ！
            }
        }
        // algorythm
        // 4.5 -> [0, 0, 0, 0, 1] -> 4 stars and 1 Half Star
        
        // Divided our cloestTier Int
        let intergerPart = Int(floor(cloestTier)) // 4 from 4.5
        let fractionalPart = cloestTier - Double(intergerPart) // 0.5 from 4.5
        
        starArray = Array(repeating: 0, count: intergerPart)
        
        if fractionalPart > 0 {
            starArray.append(1)
        }
        
        print("star array : \(starArray)")
        return starArray
    }
}

#Preview {
    ExploreView()
}
