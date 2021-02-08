//
//  TabItem.swift
//  Dicoding Meals
//
//  Created by PT Lintas Media Danawa on 02/11/20.
//  Copyright © 2020 JFS. All rights reserved.
//

import SwiftUI

struct TabItem: View {
    
    var imageName: String
    var title: String
    var body: some View {
        VStack {
            Image(systemName: imageName)
            Text(title)
        }
    }
    
}
