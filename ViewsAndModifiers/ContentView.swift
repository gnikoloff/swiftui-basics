//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Georgi Nikolov on 03.02.22.
//

import SwiftUI

// custom view container
struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    // we wrap it in @ViewBuilder so we can return tuples of View
    @ViewBuilder let content: (Int, Int) -> Content
    var body: some View {
        VStack {
            ForEach(0..<rows, id: \.self) { row in
                HStack {
                    ForEach(0..<columns, id: \.self) { column in
                        content(row, column)
                    }
                }
            }
        }
    }
}

// custom view modifier
struct Watermark: ViewModifier {
    var text: String
    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(5)
                .background(.black)
        }
    }
}

// custom view modifier
struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

// add modifier as method to view protocol
extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
    func watermarked(text: String) -> some View {
        modifier(Watermark(text: text))
    }
}
    
struct ContentView: View {
    @State private var useRedText = false
    
    var body: some View {
        ZStack {
            Color(red: 0.1, green: 0.2, blue: 0.5)
            VStack {
                GridStack(rows: 4, columns: 4) { row, col in
                    Image(systemName: "\(row * 4 + col).circle")
                    Text("R\(row) C\(col)")
                }
                Text("Hello world!").titleStyle()
                Text("Hello world!")
                    .titleStyle()
                    .watermarked(text: "My wtermark")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
