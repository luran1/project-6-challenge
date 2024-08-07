//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Madison Francis on 7/15/24.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    // Names of all the flag contries. suffled to improve playablity
    
    
    
    @State private var correctAnswer = Int.random(in: 0...2)
    // The correct answer integer (relative to the contries array
    
    @State private var showingScore = false
    // Bool to track if an alert to go off showing the result of the round.
    
    @State private var scoreTitle = ""
    // Message for alert telling user if the round was correct or wrong
    
    @State private var score = 0
    // Current score of the game, updated per round
    
    @State private var buttonPressed = 0
    // User selected flag (to be compared to correctAnswer).
    
    @State private var gameOver = false
    // Bool to track if 8 questions were asked
    
    @State private var questionsAsked = 0
    // tracks the number of questions asked
    
    // Introduction "Guess the Flag" and question counter
    var intro: some View{
        VStack(spacing: 15){
            Text("Guess the Flag")
                .font(.title)
                .fontWeight(.semibold)
                .foregroundStyle(.primary)
            Text("Question \(questionsAsked+1)/8")
                .font(.title2)
                .foregroundStyle(.primary)
        }
    }
    // VStack displaying the Introduction to the game. Name of game "Guess the Flag" and the current/number of remaining questions to ask.
    
    var Instruction: some View{
        VStack{
            Text("Tap the correct Country for")
                .foregroundStyle(.white)
                .font(.title3)
                .fontWeight(.semibold)
            Text(countries[correctAnswer])
                .foregroundStyle(.white)
                .font(.largeTitle)
                .fontWeight(.bold)
        }
    }
    // VStack with the object of the game and generates the flag to guess
    
    var body: some View {
        ZStack{
            LinearGradient(colors: [Color(red: 0.1, green: 0.46,blue: 0.5),.black], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack(spacing: 50){
                intro
                VStack(spacing: 30){
                    Instruction
                    ForEach(0..<3){ number in
                        
                            flagTappedView(number)
                            
                        
                    }
                    
                }
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.largeTitle)
            }
        }
        .alert("Game Over", isPresented: $gameOver){
            Button("Play Again", action: resetGame)
        } message: {
            Text("Your score is \(score)")
        }
        .alert(scoreTitle, isPresented: $showingScore){
            Button("Continue", action: askQuestion)
        } message: {
            if(scoreTitle == "Correct"){
                Text("your score is \(score)")
            }
            else{
                Text("This is the flag of \(countries[buttonPressed]).")
                
            }
        }
        
        
        
    }
    
    func flagTappedView(_ number: Int) -> some View{
        Button {
            
                flagTapped(number)
               
            
        } label: {
            Image(countries[number])
                
        }
        .clipShape(.buttonBorder)
        .shadow(radius: 5)
        
        
        
        
        
    }
    // Generates a Button with the Image of a flag. flag shown relative to Index passed for contries.
    
    func flagTapped(_ number: Int){
        questionsAsked += 1
        if number == correctAnswer{
            scoreTitle = "Correct"
            score+=1
            
        } else {
            scoreTitle = "Wrong"
            buttonPressed = number
        }
        if questionsAsked == 8 {
            gameOver = true
            showingScore = false
            questionsAsked = 0
        } else {
            showingScore = true
            
        }
    }
    // checks if the flag tapped is correct or wrong and updates relavent states
    
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    // Generates the next round. resuffles the contries array and selectes a new correct answer for correctAnswer.
    
    func resetGame(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        score = 0
    }
    // resuffles the contries array, selectes a new correct answer for correctAnswer, and resets the score.
}

#Preview {
    ContentView()
}
