//
//  MyReminderLists.swift
//  Reminder
//
//  Created by Hardijs on 01/08/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import SwiftUI

struct MyReminderLists: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(
        entity: ReminderList.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \ReminderList.name, ascending: true),
            NSSortDescriptor(keyPath: \ReminderList.iconColor, ascending: false)
        ]
    ) var reminderListArray: FetchedResults<ReminderList>
    
    init() {
        UITableView.appearance().backgroundColor = UIColor(named: "CustomForeground")
    }
    
    var body: some View {
        VStack() {
            HStack() {
                Text("My Lists").font(.title).bold().padding(.leading, 10)
                Spacer()
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Text("UPGRADE").font(.caption).bold().foregroundColor(Color("CustomForeground")).padding(5).padding(.leading, 10).padding(.trailing, 10).background(Color.blue).cornerRadius(20)
                }
            }.padding(.bottom, -15)
            
            if !reminderListArray.isEmpty {
                List() {
                    ForEach(self.reminderListArray, id: \.self) { reminderList in
                        MyListsCell(reminderList: reminderList).padding(.leading, -5)
                    }.onDelete(perform: self.delete)
                }.animation(.default).cornerRadius(10).frame(height: CGFloat( self.reminderListArray.count * 44))
                
            }
            Spacer()
            
        }.padding(.leading, 10).padding(.trailing, 10).padding(.top, 15).padding(.bottom, -15).animation(.default)
    }
    
    func delete(at offsets: IndexSet) {
        for index in offsets {
            let reminderList = reminderListArray[index]
            managedObjectContext.delete(reminderList)
        }
    }
}


struct MyReminderLists_Previews: PreviewProvider {
    static var previews: some View {
        MyReminderLists()
    }
}
