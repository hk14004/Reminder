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
    var request: FetchRequest<ReminderEntity>
    var reminderArray: FetchedResults<ReminderEntity>{ request.wrappedValue }
    @Environment(\.managedObjectContext) var managedObjectContext
    var reminderList: ReminderListEntity
    @State var newReminderText: String = ""
    @State var addingNewReminder: Bool = false
    @State var completeReminder: Bool = false
        
    init(reminderList: ReminderListEntity) {
        self.request = FetchRequest(
            entity: ReminderEntity.entity(),
            sortDescriptors: [NSSortDescriptor(keyPath: \ReminderListEntity.orderPriority, ascending: true)],
            predicate: NSPredicate(format: "reminderList=%@ AND completed=%d", "\(reminderList.id?.uuidString ?? "")", false)
        )
        self.reminderList = reminderList
    }
    
    var body: some View {
        VStack() {
            reminderListNameView()
            if reminderArray.count == 0 && !addingNewReminder {
                emptyAddReminderToggleView()
                Text("No Reminders").font(.title).foregroundColor(.gray).onTapGesture {
                    self.toggleAddReminder()
                }
            } else {
                //So that we can just reload new table without animation on insert
                if addingNewReminder {
                    reminderListContainerView()
                } else {
                    reminderListContainerView()
                }
            }
            emptyAddReminderToggleView()
            addNewReminderButtonView()
        }.background(Color("customForeground")).navigationBarItems(trailing:
            Button(action: {}) {
                Image(systemName: "ellipsis").resizable().aspectRatio(contentMode: .fit).frame(width: 22, height: 22).foregroundColor(Color.blue).padding(5).background(Color("CustomBackground")).cornerRadius(30)
            }
            ).navigationBarColor(.white).navigationBarTitle("", displayMode: .inline).onDisappear {(UIApplication.shared.delegate as? AppDelegate)?.saveContext()}
    }
    
    private func reminderListContainerView() -> some View {
        List() {
            ForEach(self.reminderArray, id: \.self) { currentReminder in
                ReminderCellView(reminder: currentReminder, reminderListColor: COLORS[Int(self.reminderList.iconColor)])
            }.onDelete(perform: self.deleteReminder)
            if addingNewReminder {
                NewReminderCellView(reminderText: $newReminderText, completed: $completeReminder, reminderColor: COLORS[Int(reminderList.iconColor)], addingNewReminder: $addingNewReminder, reminderList: reminderList)
            }
        }.frame(height: CGFloat( self.reminderArray.count * 50 + (addingNewReminder ? 42 : 0))).onAppear {
            UITableView.appearance().separatorInset = UIEdgeInsets(top: 0, left: 60, bottom: 0, right: 0)
        }
    }
    
    private func toggleAddReminder() {
        if !self.newReminderText.isEmpty && addingNewReminder {
            let r = ReminderEntity(context: managedObjectContext)
            r.completed = self.completeReminder
            r.orderPriority = getLastReminderID() + 1
            r.reminderList = self.reminderList.id?.uuidString
            r.text = self.newReminderText
            r.id = UUID()
            
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
        }
        
        reminderArray.forEach {
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
    
    private func getLastReminderID() -> Int64 {
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
    
    private func deleteReminder(at offsets: IndexSet) {
        for index in offsets {
            let reminder = reminderArray[index]
            managedObjectContext.delete(reminder)
        }
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }

    private func emptyAddReminderToggleView() -> some View {
        VStack {
            Color.black.opacity(0.001)
            Spacer()
        }.onTapGesture {
            self.toggleAddReminder()
        }
    }
    
    private func reminderListNameView() -> some View {
        HStack() {
            Text("\(reminderList.name ?? "")").foregroundColor(COLORS[Int(reminderList.iconColor)]).font(.title).bold()
            Spacer()
        }.padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
    }
    
    private func addNewReminderButtonView() -> some View {
        HStack() {
            Button(action: {
                self.toggleAddReminder()
            }) {
                Image(systemName: "plus.circle.fill").resizable().aspectRatio(contentMode: .fit).frame(width: 25, height: 25).foregroundColor(COLORS[Int(reminderList.iconColor)])
                Text("New Reminder").foregroundColor(COLORS[Int(reminderList.iconColor)]).bold()
            }
            Spacer()
        }.padding(15)
    }
}
