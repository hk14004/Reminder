//
//  SearchBar.swift
//  Reminder
//
//  Created by Hardijs on 28/07/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    @Binding var isEditing: Bool
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass").resizable().frame(width: 15,height: 15).foregroundColor(.gray)
                TextField("Search", text: $searchText)
                Image(systemName: "xmark.circle.fill").resizable().frame(width: 15,height: 15).foregroundColor(.gray).opacity(searchText.isEmpty ? 0 : 1).onTapGesture {
                    self.searchText = ""
                }
            }.padding(7).background(!isEditing ? Color("CustomForeground") : Color(UIColor.systemGray5)).cornerRadius(8).onTapGesture {
                self.isEditing = true
            }.animation(.default)
            
            if isEditing {
                Button(action: {
                    withAnimation(.default) {
                        self.isEditing = false
                        self.searchText = ""
                    }
                }) {
                    Text("Cancel")
                }.animation(.default)
            }
        }.padding(15).padding(.top, isEditing ? 10 : 0).background(isEditing ? Color("CustomForeground") : Color("CustomForeground").opacity(0)).edgesIgnoringSafeArea(.top).animation(.interactiveSpring())
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchText: .constant(""), isEditing: .constant(true))
    }
}

