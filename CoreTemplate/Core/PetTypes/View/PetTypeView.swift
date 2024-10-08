//
//  BrowswPetTypeCategory.swift
//  CoreTemplate
//
//  Created by Hualiteq International on 2024/5/13.
//

import SwiftUI

struct PetTypeView: View {
    
    @State var pet = ["Dog", "Cat", "Birdy"]
    @State var bkgColor = [Color("myorange"), Color("mygreen"), Color("mypurple") ]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
               
                ForEach(0..<pet.count, id: \.self) { index in
                    
                    VStack {
                        ZStack {
                            
                            Rectangle()
                                .fill(bkgColor[index])
                                .frame(width: 150, height: 81)
                                .cornerRadius(20)
                            
                            HStack {
                                Image("pet\(index)")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 76, height: 76)
                                    .padding(.top, 5)
                                    .clipped()
                                
                                Text(pet[index])
                                    .font(.custom("BrandonGrotesque-Medium", size: 20))
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    PetTypeView()
}
