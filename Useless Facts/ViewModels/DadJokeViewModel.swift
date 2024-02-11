//
//  FactViewModel.swift
//  Useless Facts
//
//  Created by Sam Hoag on 2/9/24.
//

import Foundation
import SwiftUI

class DadJokeViewModel: ObservableObject {
    @Published var joke: String = "loading hilarious joke..."
    @Published var backgroundColor: Color = Color()
    @Published var joke_lineup: [String] = []
    
    
    init() {
        fetchData()
    }
    
    func fetchData() {
        self.backgroundColor = Color()
        let url = URL(string: "https://icanhazdadjoke.com/")!
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "Accept")

            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    print("Error retrieving data!")
                    return
                }

                do {
                    self.joke_lineup.append(try JSONDecoder().decode(DadJoke.self, from: data).joke)
                    print(self.backgroundColor)
                    self.joke = self.joke_lineup.removeFirst()
    
                } catch {
                    print("Error decoding!")
                }
            }

            task.resume()
    }
    
    func swipeLeft() {
        fetchData()
    }
    
    func swipeRight() {
        fetchData()
    }

    
}
