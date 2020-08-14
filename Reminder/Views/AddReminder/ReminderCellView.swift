//
//  ReminderCell.swift
//  Reminder
//
//  Created by Hardijs on 07/08/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import SwiftUI

struct ReminderCellView: View {
    @ObservedObject var reminder: ReminderEntity
    @State var reminderListColor: Color
    
    var body: some View {
        HStack() {
            Button(action: {
               self.reminder.completed = self.reminder.completed ? false : true
            }) {
                if !reminder.completed {
                    RoundedRectangle(cornerRadius: 15, style: .continuous).stroke(Color.gray, lineWidth: 2).frame(width: 20, height: 20)
                } else {
                    RoundedRectangle(cornerRadius: 15, style: .continuous).foregroundColor(self.reminderListColor).frame(width: 15, height: 15).padding(3).overlay(RoundedRectangle(cornerRadius: 30).stroke(self.reminderListColor, lineWidth: 2))
                }
            }

            TextField("Write a reminder", text: Binding($reminder.text, ""))
//            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
//                Image(systemName: "info.circle").resizable().frame(width: 20, height: 20).padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
//            }
        }.padding(.leading, 15)
    }
}

//struct ReminderCell_Previews: PreviewProvider {
//    static var previews: some View {
//        ReminderCellView(reminder: <#T##ReminderEntity#>, newReminderText: <#T##String#>)
//    }
//}
