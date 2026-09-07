//
//  ContentView.swift
//  IOS_Development_Guide
//
//  Created by Rishabh kumar on 07/09/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Image("nature")
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text("Niagara Fall")
                .font(.title)
                .bold()
            Text("Come Visit for an experince of a Lifetime.")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
