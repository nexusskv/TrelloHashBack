//
//  HashCalculationController.swift
//  TrelloTestTask
//
//  Created by Rost on 18.10.16.
//  Copyright © 2016 Rost Gress. All rights reserved.
//

import Foundation


class HashCalculationController {
    let letters: String       = "acdegilmnoprstuw"
    
    
    // ---> General function <--- //
    
    func createHash(s: String) -> Int64 {
        let hashMultyValue: Int64 = 37
        var hashLength: Int64      = 7
        let recievedArray          = Array(s.characters)
        
        for i in (0 ..< recievedArray.count) {
            let stringCharacter: Character = recievedArray[i]
            
            let characterIndex = indexByCharacter(string: letters, character: stringCharacter)
            
            let multipleOverflow = Int64.multiplyWithOverflow(hashLength, hashMultyValue)
            
            if (!multipleOverflow.overflow) {           // CHECK FOR OVERFLOW BOUNDS
                let resultOverflow = Int64.addWithOverflow((hashLength * hashMultyValue), Int64(characterIndex))
                
                if !resultOverflow.overflow {           // CHECK FOR OVERFLOW BOUNDS
                    hashLength = (hashLength * hashMultyValue) + Int64(characterIndex)
                } else {
                    print("Int64 multiple overflow found")
                    return hashLength
                }
            } else {
                print("Int64 sum overflow found")
                return hashLength
            }
        }
        
        return hashLength
    }
    
    // ---> Help functions <--- //
    
    func isRightCharacters(characters: Array<Character>) -> Bool {
        var checkFlag = true
        
        for character in characters {
            if letters.lowercased().range(of: String(character)) == nil {
                checkFlag = false
            }
        }
        
        return checkFlag
    }
    
    func indexByCharacter(string: String, character: Character) -> Int {
        if let index = string.characters.index(of: character) {
            let position = string.characters.distance(from: string.startIndex, to: index)
            // print("Found \(character) at position \(position)")      // FOR TEST ONLY
            
            return position
        } else {
            print("Not found")
        }
        
        return 0
    }
}

extension String {
    func index(of string: String) -> String.Index? {
        return range(of: string)?.lowerBound
    }
}
