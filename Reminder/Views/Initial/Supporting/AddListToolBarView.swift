//
//  AddList.swift
//  Reminder
//
//  Created by Hardijs on 01/08/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import SwiftUI

struct AddListToolBarView: View {
    @State var visible = false
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var body: some View {
        HStack() {
            Spacer()
            
            Button(action: {
                self.visible = true
            }) {
                Text("Add list")
            }.popover(isPresented: self.$visible){
                AddReminderListPopoverView(visible: self.$visible).environment(\.managedObjectContext, self.managedObjectContext)
            }
        }.background(Color("CustomBackground").edgesIgnoringSafeArea(.bottom)).padding(10).padding(.top, 10)
    }
}

struct AddList_Previews: PreviewProvider {
    static var previews: some View {
        AddListToolBarView()
    }
}
