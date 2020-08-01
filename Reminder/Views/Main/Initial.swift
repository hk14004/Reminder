//
//  Initial.swift
//  Reminder
//
//  Created by Hardijs on 28/07/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import SwiftUI

struct Initial: View {
    @State var searchText: String = ""
    @State var isSearching: Bool = false
    var body: some View {
        VStack() {
            
            if !isSearching {
                ToolBar()
            }
            
            SearchBar(searchText: $searchText, isEditing: $isSearching)
            
            Tiles()
            
            MyReminderLists()
            
            AddList()
            
        }.background(Color("CustomBackground").edgesIgnoringSafeArea(.top))
    }
}

struct Initial_Previews: PreviewProvider {
    static var previews: some View {
        Initial()
    }
}

struct ToolBar: View {
    var body: some View {
        HStack() {
            Spacer()
            EditButton().padding([.top, .trailing]).padding(.bottom, -15)
        }.background(Color("CustomBackground").edgesIgnoringSafeArea(.top))
    }
}

struct Tiles: View {
    var body: some View {
        VStack() {
            HStack() {
                TodayTile()
                ScheduledTile()
            }.animation(.default)
            
            AllTile()
        }
    }
}

struct TodayTile: View {
    var body: some View {
        VStack() {
            HStack() {
                Image(systemName: "calendar.circle.fill").resizable().frame(width:35, height:35).foregroundColor(.blue).background(Color.white.cornerRadius(30))
                
                Spacer()
                Text("0").font(.largeTitle).bold()
            }.padding(5).padding(.bottom, -10).padding(.leading, 5).background(Color("CustomForeground"))
            
            HStack {
                Text("Today").foregroundColor(Color(UIColor.systemGray)).bold().padding(.leading, 5)
                Spacer()
            }.padding(5).padding(.top, -5).background(Color("CustomForeground"))
            
        }.background(Color("CustomForeground")).cornerRadius(10).padding(.leading, 10).padding(.trailing, 5)
    }
}

struct ScheduledTile: View {
    var body: some View {
        VStack() {
            HStack() {
                
                Image(systemName: "clock").resizable().frame(width:25, height:25).foregroundColor(.orange).overlay(RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.orange, lineWidth: 7)).background(Color.white.cornerRadius(30))
                Spacer()
                Text("0").font(.largeTitle).bold()
            }.padding(5).padding(.bottom, -10).padding(.leading, 7).background(Color("CustomForeground"))
            HStack {
                Text("Scheduled").foregroundColor(Color(UIColor.systemGray)).bold().padding(.leading, 5)
                Spacer()
            }.padding(5).padding(.top, -5).background(Color("CustomForeground"))
            
        }.background(Color("CustomForeground")).cornerRadius(10).padding(.trailing, 10).padding(.leading, 5)
    }
}

struct AllTile: View {
    var body: some View {
        HStack() {
            VStack() {
                HStack() {
                    Image(systemName: "tray.fill").resizable().aspectRatio(contentMode: .fit).frame(width:20, height:20).foregroundColor(.white).padding(8).background(Color(hex: "5B626A")).cornerRadius(30)
                    
                    Spacer()
                    Text("0").font(.largeTitle).bold()
                }.padding(5).padding(.bottom, -10).padding(.leading, 5).background(Color("CustomForeground"))
                
                HStack {
                    Text("All").foregroundColor(Color(UIColor.systemGray)).bold().padding(.leading, 5)
                    Spacer()
                }.padding(5).padding(.top, -5).background(Color("CustomForeground"))
                
            }.background(Color("CustomForeground")).cornerRadius(10).padding(.leading, 10).padding(.trailing, 10)
        }.animation(.default)
    }
}

struct MyReminderLists: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(
        entity: ReminderList.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \ReminderList.name, ascending: true),
            NSSortDescriptor(keyPath: \ReminderList.iconColor, ascending: false)
        ]
    ) var reminderListArray: FetchedResults<ReminderList>
    
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
                        MyListsCell(reminderList: reminderList).padding(.leading, -5)
                    }.onDelete(perform: self.delete)
                }.animation(.default).cornerRadius(10).frame(height: CGFloat( self.reminderListArray.count * 44))
                
            } 
            Spacer()
            
        }.padding(.leading, 10).padding(.trailing, 10).padding(.top, 15).padding(.bottom, -15).animation(.default)
    }
    
    func delete(at offsets: IndexSet) {
        for index in offsets {
            let reminderList = reminderListArray[index]
            managedObjectContext.delete(reminderList)
        }
    }
}

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
