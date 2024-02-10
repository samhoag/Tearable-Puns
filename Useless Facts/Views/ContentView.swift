//
//  ContentView.swift
//  Useless Facts
//
//  Created by Sam Hoag on 2/9/24.
//

import SwiftUI
import Foundation

extension Color {
    init() {
        let red = Int.random(in: 0...255)
        let green = Int.random(in: 0...255)
        let blue = Int.random(in: 0...255)

        // Ensure that background color is not too dark or light - ensures text readability
        let sum = red + green + blue
        if sum > 700 || sum < 150 {
            self.init()
        }
                
        
        self.init(red: Double(red) / 255.0, green: Double(green) / 255.0, blue: Double(blue) / 255.0)
    }

}

struct ContentView: View {
    @StateObject var viewModel = DadJokeViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView (showsIndicators: false){
                VStack {
                    Spacer(minLength: (geometry.size.height - 150) / 2)
                    HStack {
                        Button(action: {
                            viewModel.swipeLeft()
                        }) {
                            Text("Not funny!")
                                .foregroundColor(Color.red)
                        }
                        Spacer()
                        Button(action: {
                            viewModel.swipeRight()
                        }) {
                            Text("Funny!")
                        }
                    }
                    Spacer()
                    Text("\(viewModel.joke)")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .multilineTextAlignment(.center)
                        .font(.custom("Courier New", size: 24))
                        .padding()
                    Spacer(minLength: (geometry.size.height - 100) / 2)
                }
            }
            .frame(width: .infinity, height: .infinity)
            
            .padding()
            
        }
        .background(viewModel.backgroundColor)
    }
}

#Preview {
    ContentView()
}
