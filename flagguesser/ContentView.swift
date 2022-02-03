//
//  ContentView.swift
//  flagguesser
//
//  Created by Georgi Nikolov on 02.02.22.
//

import SwiftUI

struct ContentView: View {
    @State private var showingFinal = false
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var totalSocre = 0
    
    @State private var currentQuestionIdx = 0
    let maxQuestionsCount = 8
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            VStack {
                Spacer()
                
                Text("Guess the flag").font(.largeTitle).bold().foregroundColor(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3) { number in
                        Button() {
                            flagTapped(number)
                        } label: {
                            Image(countries[number ])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }
                    }
                }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(.regularMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                HStack {
                    Text("Question #\(currentQuestionIdx)")
                        .foregroundColor(.white)
                        .font(.title)
                        .bold()
                    Text("Score: \(totalSocre)")
                        .foregroundColor(.white)
                        .font(.title)
                        .bold()
                }
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(totalSocre)")
        }
        .alert("Game complete", isPresented: $showingFinal) {
            Button("Restart", action: restartGame)
        } message: {
            Text("You answered \(totalSocre) out of \(maxQuestionsCount) questions correct")
        }
            
    }
    
    func restartGame () {
        totalSocre = 0
        currentQuestionIdx = 0
        showingScore = false
    }
    
    func flagTapped (_ number: Int) {
        scoreTitle = number == correctAnswer ? "Correct" : "Wrong! That's the flag of \(countries[number])"
        if number == correctAnswer {
            totalSocre += 1
        }
        currentQuestionIdx += 1
        if (currentQuestionIdx == maxQuestionsCount) {
            showingFinal = true
        } else {
            showingScore = true
        }
        
        
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
