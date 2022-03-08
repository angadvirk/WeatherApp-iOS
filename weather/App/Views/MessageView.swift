//
//  MessageView.swift
//  weather
//
//  Created by Angad Singh Virk on 06/12/21.
//

import SwiftUI

struct MessageView: View {
    // Arguments
    var message: String
    // Body
    var body: some View {
        ZStack {
            Image("background").resizable().aspectRatio(contentMode: .fill).edgesIgnoringSafeArea(.all)
            HStack {
                Spacer()
                Text(message)
                    .font(.title2)
                Spacer()
            }.padding()
            .padding(.horizontal, 24)
            .frame(width: 350)
            .background(Color(hue: 1.0, saturation: 0.0, brightness: 1.0, opacity: 0.3))
            .cornerRadius(5)
            .overlay(RoundedRectangle(cornerRadius: 5)
            .stroke(Color.white, lineWidth: 1))
        }
    }
}
