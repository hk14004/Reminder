//
//  MyListsCell.swift
//  Reminder
//
//  Created by Hardijs on 30/07/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import SwiftUI

struct MyListsCellView: View {
    
    var request: FetchRequest<ReminderEntity>
    var reminderArray: FetchedResults<ReminderEntity>{ request.wrappedValue }
    @Environment(\.managedObjectContext) var managedObjectContext
    var reminderList: ReminderListEntity
    
    init(reminderList: ReminderListEntity) {
        self.request = FetchRequest(
            entity: ReminderEntity.entity(),
            sortDescriptors: [NSSortDescriptor(keyPath: \ReminderListEntity.orderPriority, ascending: true)],
            predicate: NSPredicate(format: "reminderList=%@", "\(reminderList.id?.uuidString ?? "")")
        )
        self.reminderList = reminderList
    }
    
    var body: some View {
        HStack() {
            Image(systemName: "list.bullet").resizable().frame(width:12, height: 12).aspectRatio(contentMode: .fit).foregroundColor(Color.white).padding(10).background(COLORS[Int(reminderList.iconColor)]).cornerRadius(25)
            Text("\(reminderList.name ?? "")")
            Spacer()
            Text("\(reminderArray.count)").foregroundColor(Color.gray)
        }.listRowBackground(Color("CustomForeground"))
    }
}

//struct MyListsCell_Previews: PreviewProvider {
//    static var previews: some View {
//        MyListsCellView(reminderList: ReminderListEntity(), totalReminderCount: 1)
//    }
//}
