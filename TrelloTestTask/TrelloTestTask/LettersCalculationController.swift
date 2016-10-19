//
//  LettersCalculationController.swift
//  TrelloTestTask
//
//  Created by Rost on 18.10.16.
//  Copyright © 2016 Rost Gress. All rights reserved.
//

import Foundation


class LettersCalculationController {

    
    // ---> General function <--- //
    
    func reverseHash(number: Int64) -> String {
        let letters: String       = "acdegilmnoprstuw"
        let hashLength: Int64     = 7
        let hashMultyValue: Int64 = 37
        
        let lettersArray    = Array(letters.characters)
        var resultString    = ""
        var recievedHash    = number
        
        var hashesArray: [Int64] = [number]
        
        if recievedHash > hashLength {
            while recievedHash > hashLength {
                recievedHash = recievedHash / hashMultyValue            // RESTORE HASH VALUES
                
                if recievedHash > hashLength {
                    hashesArray.append(recievedHash)            // ADD RESTORE VALUES TO ARRAY
                } else {
                    break
                }
            }
            
            hashesArray = hashesArray.reversed()            // REVERSED ALL HASHES
            
            var letterIndex: Int = 0
            var resultLettersArray: [String] = []
            
            for i in (0 ..< hashesArray.count) {
                var storedHash: Int64 = 0
                var baseHash: Int64 = 0
                
                if i > 0 {
                    storedHash = hashesArray[i - 1] // GET PREVIOUS STORED HASH FOR RIGHT BASE HASH CALC
                    baseHash = storedHash * hashMultyValue
                } else {
                    storedHash = hashesArray[0]
                    baseHash = hashLength * hashMultyValue
                }
                
                storedHash = hashesArray[i]             // GET STORED HASH FOR INDEX CALC
                letterIndex = storedHash - baseHash
                
                if letterIndex >= 0 && letterIndex < lettersArray.count {
                    let foundLetter = lettersArray[letterIndex]
                    
                    if !String(foundLetter).isEmpty {
                        resultLettersArray.append(String(foundLetter))
                    }
                }
            }
            
            if resultLettersArray.count > 0 {
                resultString = createLetters(from: resultLettersArray)
            }
            
            return resultString
        } else {
            return "Hash values for calculations is absent"
        }
    }
    
    
    // ---> Help functions <--- //
    
    func createLetters(from array: Array<String>) -> String {
        let characterArray = array.flatMap {
            String.CharacterView($0)
        }
        
        let lettersString = String(characterArray)
        
        return lettersString
    }
}
