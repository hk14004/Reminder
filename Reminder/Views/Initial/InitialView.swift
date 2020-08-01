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
        VStack() {
            
            if !isSearching {
                ToolBarView()
            }
            
            SearchBarView(searchText: $searchText, isEditing: $isSearching)
            
            TilesView()
            
            MyReminderListsView()
            
            AddListToolBarView()
            
        }.background(Color("CustomBackground").edgesIgnoringSafeArea(.top))
    }
}

struct Initial_Previews: PreviewProvider {
    static var previews: some View {
        InitialView()
    }
}
