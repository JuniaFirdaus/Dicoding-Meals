//
//  CircleImage.swift
//  Dicoding Meals
//
//  Created by PT Lintas Media Danawa on 10/11/20.
//  Copyright © 2020 JFS. All rights reserved.
//

import SwiftUI

struct CircleImage: View {
    var image: Image
    
    var body: some View {
        image
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 4))
            .shadow(radius: 150)
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage(image: Image("jfs"))
    }
}
