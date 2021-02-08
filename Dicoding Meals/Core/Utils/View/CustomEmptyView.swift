//
//  CustomEmptyView.swift
//  Dicoding Meals
//
//  Created by PT Lintas Media Danawa on 02/11/20.
//  Copyright © 2020 JFS. All rights reserved.
//

import SwiftUI

struct CustomEmptyView: View {
    var image: String
    var title: String
    
    var body: some View {
        VStack {
            Image(image)
                .resizable()
                .renderingMode(.original)
                .scaledToFit()
                .frame(width: 250)
            
            Text(title)
                .font(.system(.body, design: .rounded))
        }
    }
}
