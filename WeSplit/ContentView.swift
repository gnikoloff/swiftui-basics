//
//  ContentView.swift
//  WeSplit
//
//  Created by Georgi Nikolov on 01.02.22.
//

import SwiftUI

struct ContentView: View {
    @State private var tapCount = 0
    var body: some View {
        Button("Tap count: \(tapCount)") {
            tapCount += 1
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
