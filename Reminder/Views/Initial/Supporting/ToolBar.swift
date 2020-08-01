//
//  ToolBar.swift
//  Reminder
//
//  Created by Hardijs on 01/08/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import SwiftUI

struct ToolBar: View {
    var body: some View {
        HStack() {
            Spacer()
            EditButton().padding([.top, .trailing]).padding(.bottom, -15)
        }.background(Color("CustomBackground").edgesIgnoringSafeArea(.top))
    }
}

struct ToolBar_Previews: PreviewProvider {
    static var previews: some View {
        ToolBar()
    }
}
