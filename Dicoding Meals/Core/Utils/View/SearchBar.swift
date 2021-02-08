//
//  SearchBar.swift
//  Dicoding Meals
//
//  Created by PT Lintas Media Danawa on 02/11/20.
//  Copyright © 2020 JFS. All rights reserved.
//

import SwiftUI

struct SearchBar: UIViewRepresentable {
    
    @Binding var text: String
    var onSearchButtonClicked: (() -> Void)?
    
    class Coordinator: NSObject, UISearchBarDelegate {
        
        let control: SearchBar
        
        init(_ control: SearchBar) {
            self.control = control
        }
        
        func searchBar(
            _ searchBar: UISearchBar,
            textDidChange searchText: String
        ) {
            control.text = searchText
        }
        
        func searchBarSearchButtonClicked(
            _ searchBar: UISearchBar
        ) {
            control.onSearchButtonClicked?()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    func makeUIView(
        context: UIViewRepresentableContext<SearchBar>
    ) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        return searchBar
    }
    
    func updateUIView(
        _ uiView: UISearchBar,
        context: UIViewRepresentableContext<SearchBar>
    ) {
        uiView.text = text
    }
    
}
