//
//  Country.swift
//  RestCountriesList
//
//  Created by s.sivakarthi on 24/08/2022.
//

import Foundation

// MARK: - CountryElement
struct CountryElement: Codable {
    let name: Name?
    let independent: Bool?
    let unMember: Bool?
    let capital: [String]?
    let region: Region?
    let area: Double?
    let population: Int?
    let continents: [Continent]?
    let coatOfArms, flags: CoatOfArms?
    let flag: String?
}

enum Side: String, Codable {
    case sideLeft = "left"
    case sideRight = "right"
}

// MARK: - CoatOfArms
struct CoatOfArms: Codable {
    let png: String?
    let svg: String?
}

enum Continent: String, Codable {
    case africa = "Africa"
    case antarctica = "Antarctica"
    case asia = "Asia"
    case europe = "Europe"
    case northAmerica = "North America"
    case oceania = "Oceania"
    case southAmerica = "South America"
}

// MARK: - Name
struct Name: Codable {
    let common, official: String?
}

enum Region: String, Codable {
    case africa = "Africa"
    case americas = "Americas"
    case antarctic = "Antarctic"
    case asia = "Asia"
    case europe = "Europe"
    case oceania = "Oceania"
}

