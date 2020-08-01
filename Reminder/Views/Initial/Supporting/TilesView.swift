//
//  Tiles.swift
//  Reminder
//
//  Created by Hardijs on 01/08/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import SwiftUI

struct TilesView: View {
    var body: some View {
        VStack() {
            HStack() {
                TodayTileView()
                ScheduledTileView()
            }.animation(.default)
            
            AllTileView()
        }
    }
}

struct TodayTileView: View {
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

struct ScheduledTileView: View {
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

struct AllTileView: View {
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

struct Tiles_Previews: PreviewProvider {
    static var previews: some View {
        TilesView()
    }
}
