//
//  CharacterInformationViewModel+Helper.swift
//  RickAndMortyTests
//
//  Created by Adam Makhfoudi on 28/04/2020.
//  Copyright © 2020 Adam Makhfoudi. All rights reserved.
//

import Foundation
@testable import RickAndMorty

func parseCharacterJSON() -> Character {
    let fileURL = Bundle.main.url(forResource: "character",
                                  withExtension: "json")
    let content = try! String(contentsOf: fileURL!, encoding: String.Encoding.utf8)
    let data = content.data(using: .utf8)
    let character = try! data!.decode(decodable: Character.self)
    return character
}
