//
//  ActivityIndicator.swift
//  Dicoding Meals
//
//  Created by PT Lintas Media Danawa on 02/11/20.
//  Copyright © 2020 JFS. All rights reserved.
//

import SwiftUI

struct ActivityIndicator: UIViewRepresentable {
    
    func makeUIView(
        context: UIViewRepresentableContext<ActivityIndicator>
    ) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: .large)
    }
    
    func updateUIView(
        _ uiView: UIActivityIndicatorView,
        context: UIViewRepresentableContext<ActivityIndicator>
    ) {
        uiView.startAnimating()
    }
    
}
