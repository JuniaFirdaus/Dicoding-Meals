//
//  BlurView.swift
//  Dicoding Meals
//
//  Created by PT Lintas Media Danawa on 02/11/20.
//  Copyright © 2020 JFS. All rights reserved.
//

import SwiftUI

struct BlurView: UIViewRepresentable {
    
    func makeUIView(
        context: UIViewRepresentableContext<BlurView>
    ) -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(blurView, at: 0)
        NSLayoutConstraint.activate([
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        return view
    }
    
    func updateUIView(
        _ uiView: UIView,
        context: UIViewRepresentableContext<BlurView>
    ) {}
    
}
