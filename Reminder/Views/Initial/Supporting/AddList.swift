//
//  AddList.swift
//  Reminder
//
//  Created by Hardijs on 01/08/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import SwiftUI

struct AddList: View {
    @State var visible = false
    @Environment(\.managedObjectContext) var managedObjectContext
    @State var chosenName: String = ""
    @State var chosenColor: Int = 0
    var body: some View {
        HStack() {
            Spacer()
            
            Button(action: {
                self.visible = true
            }) {
                Text("Add list")
            }.popover(isPresented: self.$visible){
                GeometryReader { geometry in
                    // Popover content
                    VStack() {
                        HStack {
                            Button(action: {
                                self.visible = false
                                self.chosenName = ""
                                self.chosenColor = 0
                            }) {
                                Text("Cancel")
                            }
                            Spacer()
                            Text("New List").bold()
                            Spacer()
                            Button(action: {
                                let list = ReminderList(context: self.managedObjectContext)
                                list.name = self.chosenName
                                list.iconColor = Int32(self.chosenColor)
                                self.save()
                                self.visible = false
                                self.chosenName = ""
                                self.chosenColor = 0
                            }) {
                                Text("Done")
                            }.disabled(self.chosenName.isEmpty ? true : false)
                            
                        }.padding(EdgeInsets(top: 15, leading: 15, bottom: 30, trailing: 15))
                        Image(systemName: "list.bullet").resizable().aspectRatio(contentMode: .fit).frame(width: 50, height: 50).padding(30).background(COLORS[self.chosenColor]).cornerRadius(100).padding(.bottom, 20)
                        TextField("Give it a name", text: self.$chosenName).multilineTextAlignment(.center).padding(EdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 15)).background(Color(UIColor.systemGray4)).cornerRadius(10).frame(width: geometry.size.width - 30).foregroundColor(Color.white).font(.headline)
                        
                        //COLORS
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
                        }.lineLimit(10).padding(.top, 20)
                        Spacer()
                    }.frame(width: geometry.size.width, height: geometry.size.height).background(Color(UIColor.systemGray6))
                }
            }
        }.background(Color("CustomBackground").edgesIgnoringSafeArea(.bottom)).padding(10).padding(.top, 10)
    }
    
    func save() {
        do {
            try self.managedObjectContext.save()
        } catch {
            // TODO: Display alert
        }
    }
}


struct AddList_Previews: PreviewProvider {
    static var previews: some View {
        AddList()
    }
}
