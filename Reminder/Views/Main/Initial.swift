//
//  Initial.swift
//  Reminder
//
//  Created by Hardijs on 28/07/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import SwiftUI

struct Initial: View {
    @State var searchText: String = ""
    @State var isSearching: Bool = false
    var body: some View {
        VStack() {
            if !isSearching {
            HStack() {
                Spacer()
                EditButton().padding([.top, .trailing]).padding(.bottom, -15)
                }.background(Color(hex: "F2F2F7").edgesIgnoringSafeArea(.top))
            }
            SearchBar(searchText: $searchText, isEditing: $isSearching)
            Spacer()
            Text(searchText)
            Spacer()
        }.background(Color(hex: "F2F2F7").edgesIgnoringSafeArea(.top))
    }
}

struct Initial_Previews: PreviewProvider {
    static var previews: some View {
        Initial()
    }
}
