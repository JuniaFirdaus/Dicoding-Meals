//
//  AboutView.swift
//  Dicoding Meals
//
//  Created by PT Lintas Media Danawa on 10/11/20.
//  Copyright © 2020 JFS. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        ZStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    Image("dicoding").resizable()
                        .frame(width: 450, height: 350, alignment: .center)
                        .scaledToFit()
                    
                    CircleImage(image: Image("jfs").resizable())
                        .offset(x: -100, y: -80)
                        .padding(.top, 10)
                        .scaledToFill()
                        .frame(width: 150, height: 150, alignment: .center)
                    
                    Image("ic_badge_ios")
                        .resizable()
                        .frame(width: 40, height: 40, alignment: .center)
                        .offset(x: -50, y: -130)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Junia Firdaus")
                            .font(.title)
                        
                        HStack {
                            Image(systemName: "star.fill")
                                .foregroundColor(Color.black)
                            
                            Text("6900 XP")
                                .font(.subheadline)
                        }
                        
                        HStack {
                            Image(systemName: "pin.fill")
                                .foregroundColor(Color.black)
                            
                            Text("Kota Bekasi, Jawa Barat")
                                .font(.subheadline)
                        }
                        
                    }.offset(x: 80, y: -200)
                    
                    VStack(alignment: .leading) {
                        Text("Belajar")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        Text("23 Kelas Akademi")
                            .font(.title)
                            .fontWeight(.black)
                            .foregroundColor(.primary)
                            .lineLimit(3)
                        
                        Text("Memenangkan")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        Text("0 Challenge")
                            .font(.title)
                            .fontWeight(.black)
                            .foregroundColor(.primary)
                            .lineLimit(3)
                        
                        Text("Menghadiri")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        Text("3 Event")
                            .font(.title)
                            .fontWeight(.black)
                            .foregroundColor(.primary)
                            .lineLimit(3)
                        
                    }.offset(x: -40, y: -200)
                    
                }
            }.edgesIgnoringSafeArea(.top)
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
