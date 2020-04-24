//
//  CharacterInformation.swift
//  RickAndMorty
//
//  Created by Adam Makhfoudi on 24/04/2020.
//  Copyright © 2020 Adam Makhfoudi. All rights reserved.
//

class CharacterInformation: Codable {
    let info: PageInformation
    let results: [Character]
}

struct PageInformation: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

struct Character: Codable {
    let id: Int
    let name: String
    let gender: String
    let image: String
    let status: String
    let species: String
    let episode: [String]
    let location: CharacterLocation
    let origin: Origin
}

struct Origin: Codable {
    let name: String
    let url: String
}

struct CharacterLocation: Codable {
    let name: String
    let url: String
}
