//
//  AddReminderView.swift
//  Reminder
//
//  Created by Hardijs on 05/08/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import SwiftUI
import CoreData

struct AddReminderView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(
        entity: ReminderEntity.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \ReminderEntity.orderPriority, ascending: true),
        ]
    ) var reminderArray: FetchedResults<ReminderEntity>
    @State var reminderList: ReminderListEntity
    @State var newReminderText: String = ""
    @State var addingNewReminder: Bool = false
    @State var completeReminder: Bool = false
    
    var body: some View {
        VStack() {
            HStack() {
                Text("\(reminderList.name ?? "")").foregroundColor(COLORS[Int(reminderList.iconColor)]).font(.title).bold()
                Spacer()
            }.padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
            if reminderArray.count == 0 && !addingNewReminder {
                VStack {
                    Color.black.opacity(0.001)
                    Spacer()
                }.onTapGesture {
                    self.toggleAddReminder()
                }
                Text("No Reminders").font(.title).foregroundColor(.gray).onTapGesture {
                    self.toggleAddReminder()
                }
            } else {
                //So that we can just relead new table without animation on insert
                if addingNewReminder {
                    ReminderListContainerView(reminderArray: reminderArray, reminderList: $reminderList, newReminderText: $newReminderText, addingNewReminder: $addingNewReminder, completeReminder: $completeReminder)
                } else {
                    ReminderListContainerView(reminderArray: reminderArray, reminderList: $reminderList, newReminderText: $newReminderText, addingNewReminder: $addingNewReminder, completeReminder: $completeReminder)
                }
            }
            VStack {
                Color.black.opacity(0.001)
                Spacer()
            }.onTapGesture {
                self.toggleAddReminder()
            }
            
            HStack() {
                Button(action: {
                    self.toggleAddReminder()
                }) {
                    Image(systemName: "plus.circle.fill").resizable().aspectRatio(contentMode: .fit).frame(width: 25, height: 25).foregroundColor(COLORS[Int(reminderList.iconColor)])
                    Text("New Reminder").foregroundColor(COLORS[Int(reminderList.iconColor)]).bold()
                }
                Spacer()
            }.padding(15)
        }.background(Color("customForeground")).navigationBarItems(trailing:
            
            Button(action: {}) {
                Image(systemName: "ellipsis").resizable().aspectRatio(contentMode: .fit).frame(width: 22, height: 22).foregroundColor(Color.blue).padding(5).background(Color("CustomBackground")).cornerRadius(30)
            }
        ).navigationBarColor(.white).navigationBarTitle("", displayMode: .inline)
    }
    
    func toggleAddReminder() {
        if !self.newReminderText.isEmpty && addingNewReminder {
            // save
            print("SAVE!")
            let r = ReminderEntity(context: managedObjectContext)
            r.completed = self.completeReminder
            r.orderPriority = getLastID() + 1
            r.reminderList = self.reminderList.id?.uuidString
            r.text = self.newReminderText
            r.id = UUID()
            
            save()
        }
        
        reminderArray.forEach{
            if $0.text == "" {
                self.managedObjectContext.delete($0)
            }
        }
        
        self.newReminderText = ""
        self.completeReminder = false
        
        self.addingNewReminder = self.addingNewReminder ? false : true
        
        if addingNewReminder {
            UIApplication.shared.endEditing()
        }
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
    
    func save() {
        do {
            try self.managedObjectContext.save()
        } catch {
            print("Save failed \(error.localizedDescription)")
            // TODO: Display alert
        }
    }

    func delete(at offsets: IndexSet) {
        for index in offsets {
            let reminder = reminderArray[index]
            managedObjectContext.delete(reminder)
        }
        save()
    }

}

struct ReminderListContainerView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    var reminderArray: FetchedResults<ReminderEntity>
    
    @Binding var reminderList: ReminderListEntity
    @Binding var newReminderText: String
    @Binding var addingNewReminder: Bool
    @Binding var completeReminder: Bool
    var body: some View {
        List() {
            ForEach(self.reminderArray, id: \.self) { currentReminder in
                ReminderCellView(reminder: currentReminder, reminderListColor: COLORS[Int(self.reminderList.iconColor)])
            }.onDelete(perform: self.delete)
            if addingNewReminder {
                NewReminderCellView(reminderText: $newReminderText, completed: $completeReminder, reminderColor: COLORS[Int(reminderList.iconColor)], addingNewReminder: $addingNewReminder, reminderList: reminderList)
            }
        }.frame(height: CGFloat( self.reminderArray.count * 50 + (addingNewReminder ? 42 : 0))).onAppear {
            UITableView.appearance().separatorInset = UIEdgeInsets(top: 0, left: 60, bottom: 0, right: 0)
        }
    }
    
    func save() {
        do {
            try self.managedObjectContext.save()
        } catch {
            print("Save failed \(error.localizedDescription)")
            // TODO: Display alert
        }
    }

    func delete(at offsets: IndexSet) {
        for index in offsets {
            let reminder = reminderArray[index]
            managedObjectContext.delete(reminder)
        }
        save()
    }
}
