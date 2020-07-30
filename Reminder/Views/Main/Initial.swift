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
            
        }.background(Color(hex: "F2F2F7").edgesIgnoringSafeArea(.top))
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
        }.background(Color(hex: "F2F2F7").edgesIgnoringSafeArea(.top))
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
                Image(systemName: "calendar.circle.fill").resizable().frame(width:35, height:35).foregroundColor(.blue)
                
                Spacer()
                Text("0").font(.largeTitle).bold()
            }.padding(5).padding(.bottom, -10).padding(.leading, 5).background(Color.white)
            
            HStack {
                Text("Today").foregroundColor(Color(hex: "87878C")).bold().padding(.leading, 5)
                Spacer()
            }.padding(5).padding(.top, -5).background(Color.white)
            
        }.background(Color.white).cornerRadius(10).padding(.leading, 10).padding(.trailing, 5)
    }
}

struct ScheduledTile: View {
    var body: some View {
        VStack() {
            HStack() {
                
                Image(systemName: "clock").resizable().frame(width:25, height:25).foregroundColor(.orange).overlay(RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.orange, lineWidth: 7))
                Spacer()
                Text("0").font(.largeTitle).bold()
            }.padding(5).padding(.bottom, -10).padding(.leading, 7).background(Color.white)
            HStack {
                Text("Scheduled").foregroundColor(Color(hex: "87878C")).bold().padding(.leading, 5)
                Spacer()
            }.padding(5).padding(.top, -5).background(Color.white)
            
        }.background(Color.white).cornerRadius(10).padding(.trailing, 10).padding(.leading, 5)
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
                }.padding(5).padding(.bottom, -10).padding(.leading, 5).background(Color.white)
                
                HStack {
                    Text("All").foregroundColor(Color(hex: "87878C")).bold().padding(.leading, 5)
                    Spacer()
                }.padding(5).padding(.top, -5).background(Color.white)
                
            }.background(Color.white).cornerRadius(10).padding(.leading, 10).padding(.trailing, 10)
        }.animation(.default)
    }
}

struct MyReminderLists: View {
    var body: some View {
        VStack() {
            HStack() {
                Text("My Lists").font(.title).bold().padding(.leading, 10)
                Spacer()
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Text("UPGRADE").font(.caption).bold().foregroundColor(Color.white).padding(5).padding(.leading, 10).padding(.trailing, 10).background(Color.blue).cornerRadius(20)
                }
            }.padding(.bottom, -15)
            List() {
                MyListsCell(reminderList: ReminderList(name: "Reminders", color: .red)).padding(.leading, -5)
            }.cornerRadius(10).animation(.default)
            
        }.padding(.leading, 10).padding(.trailing, 10).padding(.top, 15).padding(.bottom, -15).animation(.default)
    }
}

struct AddList: View {
    var body: some View {
        HStack() {
            Spacer()
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                Text("Add list")
            }
        }.background(Color(hex: "F2F2F7").edgesIgnoringSafeArea(.bottom)).padding(10).padding(.top, 10)
    }
}
