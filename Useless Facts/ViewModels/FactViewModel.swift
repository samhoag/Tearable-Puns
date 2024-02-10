//
//  FactViewModel.swift
//  Useless Facts
//
//  Created by Sam Hoag on 2/9/24.
//

import Foundation
import SwiftUI

class FactViewModel: ObservableObject {
    @Published var fact: String = "loading useless fact..."
    @Published var backgroundColor: Color = Color(red: .random(in: 0...255), green: .random(in: 0...255), blue: .random(in: 0...255))
    
    init() {
        fetchData()
    }
    
    func fetchData() {
        self.backgroundColor = self.randomColor()
        // API endpoint URL
        guard let url = URL(string: "https://uselessfacts.jsph.pl/api/v2/facts/random") else {
            return
        }
        
        // Create a URL session
        URLSession.shared.dataTask(with: url) { data, response, error in
            // Check for errors
            if let error = error {
                return
            }
            
            // Check for response status code
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                return
            }
            
            // Check if data is available
            guard let data = data else {
                return
            }
            
            do {
                // Decode JSON into the Fact model
                let fact = try JSONDecoder().decode(Fact.self, from: data)
                self.fact = fact.text
                
                print(self.backgroundColor)
            } catch {
            }
        }.resume()
    }
    
    func randomColor() -> Color {
        return Color(red: .random(in: 0...255), green: .random(in: 0...255), blue: .random(in: 0...255))
    }
    
}
