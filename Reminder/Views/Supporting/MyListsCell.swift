//
//  MyListsCell.swift
//  Reminder
//
//  Created by Hardijs on 30/07/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import SwiftUI

struct MyListsCell: View {
    @State var reminderList: ReminderList
    
    var body: some View {
        HStack() {
            Image(systemName: "list.bullet").resizable().frame(width:12, height: 12).aspectRatio(contentMode: .fit).foregroundColor(Color.white).padding(10).background(COLORS[Int(reminderList.iconColor)]).cornerRadius(25)
            Text("\(reminderList.name ?? "")")
            Spacer()
            Text("TODO")
        }.listRowBackground(Color("CustomForeground"))
    }
}

struct MyListsCell_Previews: PreviewProvider {
    static var previews: some View {
        MyListsCell(reminderList: ReminderList())
    }
}
