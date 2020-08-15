//
//  MyReminderLists.swift
//  Reminder
//
//  Created by Hardijs on 01/08/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import SwiftUI
import CoreData

struct MyReminderListsView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(
        entity: ReminderListEntity.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \ReminderListEntity.orderPriority, ascending: true),
        ]
    ) var reminderListArray: FetchedResults<ReminderListEntity>
    
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
                        NavigationLink(destination: AddReminderView(reminderList: reminderList)) {
                            MyListsCellView(reminderList: reminderList).padding(.leading, -5)
                        }
                    }.onDelete(perform: self.delete).onMove(perform: move)
                }.animation(.default).cornerRadius(10).frame(height: CGFloat( self.reminderListArray.count * 44)).onAppear {UITableView.appearance().separatorInset = UIEdgeInsets(top: 0, left: 55, bottom: 0, right: 0)}
            }
            Spacer()
            
        }.padding(.leading, 10).padding(.trailing, 10).padding(.top, 15).padding(.bottom, -15).animation(.default)
    }
    
    func move(from source: IndexSet, to destination: Int) {
        var orderedArray: [ReminderListEntity] = reminderListArray.map {$0}
        orderedArray.move(fromOffsets: source, toOffset: destination)
        
        for i in 0..<orderedArray.count {
            let saved = reminderListArray.first { $0.id == orderedArray[i].id }
            saved?.orderPriority = Int64(i)
        }
        
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    func delete(at offsets: IndexSet) {
        for index in offsets {
            let reminderList = reminderListArray[index]
            managedObjectContext.delete(reminderList)
        }
    }
}

struct MyReminderListsView_Previews: PreviewProvider {
    static var previews: some View {
        MyReminderListsView()
    }
}
