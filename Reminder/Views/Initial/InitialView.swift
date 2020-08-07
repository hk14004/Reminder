//
//  Initial.swift
//  Reminder
//
//  Created by Hardijs on 28/07/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import SwiftUI

struct InitialView: View {
    @State var searchText: String = ""
    @State var isSearching: Bool = false
    var body: some View {
        NavigationView {
            VStack() {
                
                if !isSearching {
                    ToolBarView()
                }
                
                SearchBarView(searchText: $searchText, isEditing: $isSearching)
                
                TilesView()
                
                MyReminderListsView()
                
                AddListToolBarView()
            }.background(Color("CustomBackground")).navigationBarTitle("Lists")
                .navigationBarHidden(true)
        }
        
    }
}

struct Initial_Previews: PreviewProvider {
    static var previews: some View {
        InitialView()
    }
}
