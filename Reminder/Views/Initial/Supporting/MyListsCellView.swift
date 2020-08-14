//
//  MyListsCell.swift
//  Reminder
//
//  Created by Hardijs on 30/07/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import SwiftUI

struct MyListsCellView: View {
    @State var reminderList: ReminderListEntity
    @State var totalReminderCount: Int
    
    var body: some View {
        HStack() {
            Image(systemName: "list.bullet").resizable().frame(width:12, height: 12).aspectRatio(contentMode: .fit).foregroundColor(Color.white).padding(10).background(COLORS[Int(reminderList.iconColor)]).cornerRadius(25)
            Text("\(reminderList.name ?? "")")
            Spacer()
            Text("\(totalReminderCount)").foregroundColor(Color.gray)
        }.listRowBackground(Color("CustomForeground"))
    }
}

struct MyListsCell_Previews: PreviewProvider {
    static var previews: some View {
        MyListsCellView(reminderList: ReminderListEntity(), totalReminderCount: 1)
    }
}
