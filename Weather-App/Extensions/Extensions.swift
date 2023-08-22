//
//  Extensions.swift
//  Weather-App
//
//  Created by Matt Sullivan on 22/08/2023.
//

extension String {
    var capitalizedSentence: String {
        let firstLetter = self.prefix(1).capitalized
        let remainingLetters = self.dropFirst().lowercased()
        
        return firstLetter + remainingLetters
    }
}
