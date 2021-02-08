//
//  CustomIcon.swift
//  Dicoding Meals
//
//  Created by PT Lintas Media Danawa on 02/11/20.
//  Copyright © 2020 JFS. All rights reserved.
//

import SwiftUI

struct CustomIcon: View {
    
    var imageName: String
    var title: String
    
    var body: some View {
        VStack {
            Image(systemName: imageName)
                .font(.system(size: 28))
                .foregroundColor(.orange)
            
            Text(title)
                .font(.caption)
                .padding(.top, 8)
        }
    }
    
}
