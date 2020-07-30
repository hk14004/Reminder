//
//  MyListsCell.swift
//  Reminder
//
//  Created by Hardijs on 30/07/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import SwiftUI

struct MyListsCell: View {
    var reminderList: ReminderList
    
    var body: some View {
        HStack() {
            Image(systemName: "list.bullet").resizable().frame(width:12, height: 12).aspectRatio(contentMode: .fit).foregroundColor(Color.white).padding(10).background(reminderList.color).cornerRadius(25)
            Text("\(reminderList.name)")
            Spacer()
            Text("\(reminderList.reminders.count)")
        }
        
    }
}

struct MyListsCell_Previews: PreviewProvider {
    static var previews: some View {
        MyListsCell(reminderList: ReminderList(name: "Reminders", color: .red))
    }
}


class ReminderList: Identifiable {
     var name: String
     var color: Color
     var reminders: [String] = [""]
    
    init(name: String, color: Color) {
        self.name = name
        self.color = color
    }
}
