//
//  NewListPopoverView.swift
//  Reminder
//
//  Created by Hardijs on 01/08/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import SwiftUI

struct NewReminderListPopoverView: View {
    @State var chosenColor: Int = 0
    @State var chosenName: String = ""
    @Binding var visible: Bool
    
    var body: some View {
        GeometryReader { geometry in
            VStack() {
                NewListPopupToolBar(popoverVisible: self.$visible, chosenColor: self.$chosenColor, chosenName: self.$chosenName)
                Image(systemName: "list.bullet").resizable().aspectRatio(contentMode: .fit).frame(width: 50, height: 50).padding(30).background(COLORS[self.chosenColor]).cornerRadius(100).padding(.bottom, 20)
                TextField("Give it a name", text: self.$chosenName).multilineTextAlignment(.center).padding(EdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 15)).background(Color(UIColor.systemGray4)).cornerRadius(10).frame(width: geometry.size.width - 30).foregroundColor(Color.white).font(.headline)
                
                ColorPickerView(chosenColor: self.$chosenColor)
                Spacer()
            }.frame(width: geometry.size.width, height: geometry.size.height).background(Color(UIColor.systemGray6))
        }
    }
}

struct ColorPickerView: View {
    @Binding var chosenColor: Int
    
    var body: some View {
        HStack() {
            ForEach(0 ..< COLORS.count - 1) { color in
                Button(action: {
                    self.chosenColor = color
                }) {
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(COLORS[color])
                        .frame(width: 40, height: 40).overlay(RoundedRectangle(cornerRadius: 50, style: .continuous).stroke(lineWidth: 3).padding(-5).foregroundColor(Color(UIColor.systemGray3)).opacity(self.chosenColor == color ? 1 : 0)).padding(5)
                }
            }
        }.padding(.top, 20)
    }
}


struct NewListPopoverView_Previews: PreviewProvider {
    static var previews: some View {
        NewReminderListPopoverView(visible: .constant(true))
    }
}

struct NewListPopupToolBar: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Binding var popoverVisible: Bool
    @Binding var chosenColor: Int
    @Binding var chosenName: String
    
    var body: some View {
        HStack {
            Button(action: {
                self.popoverVisible = false
                self.chosenName = ""
                self.chosenColor = 0
            }) {
                Text("Cancel")
            }
            Spacer()
            Text("New List").bold()
            Spacer()
            Button(action: {
                let list = ReminderListEntity(context: self.managedObjectContext)
                list.name = self.chosenName
                list.iconColor = Int32(self.chosenColor)
                list.id = UUID()
                self.save()
                self.popoverVisible = false
                self.chosenName = "wtf"
                self.chosenColor = 0
            }) {
                Text("Done")
            }.disabled(self.chosenName.isEmpty ? true : false)
            
        }.padding(EdgeInsets(top: 15, leading: 15, bottom: 30, trailing: 15))
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
