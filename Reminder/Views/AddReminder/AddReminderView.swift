//
//  AddReminderView.swift
//  Reminder
//
//  Created by Hardijs on 05/08/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import SwiftUI

struct AddReminderView: View {
    @State var reminderList: ReminderListEntity
    
    var body: some View {
        VStack() {
            HStack() {
                Text("\(reminderList.name ?? "gg")").foregroundColor(COLORS[Int(reminderList.iconColor)]).font(.title).bold()
                Spacer()
            }.padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
            Spacer()
            Text("No Reminders").font(.title).foregroundColor(.gray)
            Spacer()
            HStack() {
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Image(systemName: "plus.circle.fill").resizable().aspectRatio(contentMode: .fit).frame(width: 25, height: 25).foregroundColor(.red)
                    Text("New Reminder").foregroundColor(.red).bold()
                }
                Spacer()
            }.padding(15)
        }.background(Color("customForeground")).navigationBarItems(trailing:
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                Image(systemName: "ellipsis").resizable().aspectRatio(contentMode: .fit).frame(width: 22, height: 22).foregroundColor(Color.blue).padding(5).background(Color("CustomBackground")).cornerRadius(30)
            }
        ).navigationBarColor(.white).navigationBarTitle("", displayMode: .inline)
    }
}
