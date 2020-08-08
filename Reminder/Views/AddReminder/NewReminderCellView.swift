//
//  ReminderCell.swift
//  Reminder
//
//  Created by Hardijs on 07/08/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import SwiftUI
import CoreData

struct NewReminderCellView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Binding var reminderText: String
    @Binding var completed: Bool
    @State var reminderColor: Color
    @Binding var addingNewReminder: Bool
    @State var reminderList: ReminderListEntity
    
    var body: some View {
        HStack() {
            Button(action: {
               self.completed = self.completed ? false : true
            }) {
                if !self.completed {
                    RoundedRectangle(cornerRadius: 15, style: .continuous).stroke(Color.gray, lineWidth: 2).frame(width: 20, height: 20)
                } else {
                    RoundedRectangle(cornerRadius: 15, style: .continuous).foregroundColor(reminderColor).frame(width: 15, height: 15).padding(3).overlay(RoundedRectangle(cornerRadius: 30).stroke(reminderColor, lineWidth: 2))
                }
            }

            TextField("Reminder text", text: $reminderText, onCommit: {
                self.toggleAddReminder()
            })
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                Image(systemName: "info.circle").resizable().frame(width: 20, height: 20).padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
            }
        }.padding(.leading, 15)
    }
    
    private func getLastID() -> Int64 {
        let fetchRequest = NSFetchRequest<ReminderEntity>(entityName: "ReminderEntity")
        
        fetchRequest.fetchLimit = 1
        let sortDescriptor = NSSortDescriptor(key: "orderPriority", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            let list = try managedObjectContext.fetch(fetchRequest)
            print(list)
            return list.count == 0 ? 0 : list[0].orderPriority
        } catch let error as NSError {
            // failure
            print("Fetch failed: \(error.localizedDescription)")
            return 0
        }
    }
    
        func toggleAddReminder() {
            if !self.reminderText.isEmpty && addingNewReminder {
                // save
                print("SAVE!")
                let r = ReminderEntity(context: managedObjectContext)
                r.completed = self.completed
                r.orderPriority = getLastID() + 1
                r.reminderList = self.reminderList.id?.uuidString
                r.text = self.reminderText
                r.id = UUID()
                
                save()
            }
            
            self.addingNewReminder = self.addingNewReminder ? false : true
            
            if addingNewReminder {
                UIApplication.shared.endEditing()
//                self.reminderText = ""
//                self.completed = false
            }
        }
    func removeEmpty() {
        //self.managedObjectContext.
    }
    func save() {
        do {
            
            try self.managedObjectContext.save()
        } catch {
            print("Save failed \(error.localizedDescription)")
            // TODO: Display alert
        }
    }
}
//
//struct ReminderCell_Previews: PreviewProvider {
//    static var previews: some View {
//        NewReminderCellView(reminderText: "Text", completed: false, reminderColor: .green)
//    }
//}
