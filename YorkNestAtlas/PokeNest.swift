//
//  PokePin.swift
//  YorkNestAtlas
//
//  Created by Jonathan Bones on 04.06.17.
//  Copyright © 2017 Jonathan Bones. All rights reserved.
//

import Foundation
import MapKit
import Contacts
import UIKit

class PokeNest: NSObject, MKAnnotation {
    
    //Enum for logging error messages to console
    enum SerialisationError: Error {
        case missing(String)
    }
    
    let coordinate: CLLocationCoordinate2D
    let pokemonName: String?
    let pokedexEntry: Int
    let nestVerified: Bool
    let pokeType: String
    
    var title: String? {
        return pokemonName
    }
    
    var subtitle: String? {
        return String(pokedexEntry)
    }
    
    init(pokemonName: String, pokedexEntry: Int, pokemonType: String, coordinate:CLLocationCoordinate2D, nestVerified: Bool){
        self.pokemonName = pokemonName
        self.pokedexEntry = pokedexEntry
        self.coordinate = coordinate
        self.nestVerified = nestVerified
        self.pokeType = pokemonType
        super.init()
    }
    
    //Function to extract data from the JSON file
    func extractNestsFromJSON(json: [String: Any]) -> PokeNest {
        var pokemonName: String = ""
        var latitude: Double = 0.0
        var longitude: Double = 0.0
        var pokedexEntry: Int = 0
        var verified: Bool = false
        var pokeType: String = ""
        
        if let jsonPokemonName = json["pokemon"] as? String {
            pokemonName = jsonPokemonName
        }
        
        if let jsonLatitude = json["latitude"] as? Double, let jsonLongitude = json["longitude"] as? Double {
            latitude = jsonLatitude
            longitude = jsonLongitude
        }
        
        if let jsonPokedexEntry = json["pokedexEntry"] as? Int {
            pokedexEntry = jsonPokedexEntry
        }
        
        if let jsonVerified = json["verified"] as? Bool {
            verified = jsonVerified
        }
        if let jsonType = json["type"] as? String {
            pokeType = jsonType
        }
        
        let nestCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        return PokeNest(pokemonName: pokemonName, pokedexEntry: pokedexEntry, pokemonType: pokeType, coordinate: nestCoordinate, nestVerified: verified)
    }
    
    func mapItem() -> MKMapItem {
        let addressDict = [String(CNPostalAddressStreetKey): self.subtitle as AnyObject]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        
        return mapItem
    }
    
    func pinColour() -> UIColor {
        switch pokeType {
        case "bug":
            return UIColor(colorLiteralRed: 95.0/255.0, green: 174.0/255.0, blue: 54.0/255.0, alpha: 1.0)
        case "dark":
            return UIColor(colorLiteralRed: 80.0/255.0, green: 76.0/255.0, blue: 91.0/255.0, alpha: 1.0)
        case "dragon":
            return UIColor(colorLiteralRed: 32.0/255.0, green: 106.0/255.0, blue: 180.0/255.0, alpha: 1.0)
        case "electric":
            return UIColor(colorLiteralRed: 255.0/255.0, green: 207.0/255.0, blue: 90.0/255.0, alpha: 1.0)
        case "fairy":
            return UIColor(colorLiteralRed: 243.0/255.0, green: 166.0/255.0, blue: 216.0/255.0, alpha: 1.0)
        case "fighting":
            return UIColor(colorLiteralRed: 211.0/255.0, green: 75.0/255.0, blue: 98.0/255.0, alpha: 1.0)
        case "fire":
            return UIColor(colorLiteralRed: 255.0/255.0, green: 149.0/255.0, blue: 71.0/255.0, alpha: 1.0)
        case "flying":
            return UIColor(colorLiteralRed: 117.0/255.0, green: 142.0/255.0, blue: 213.0/255.0, alpha: 1.0)
        case "ghost":
            return UIColor(colorLiteralRed: 131.0/255.0, green: 119.0/255.0, blue: 195.0/255.0, alpha: 1.0)
        case "grass":
            return UIColor(colorLiteralRed: 44.0/255.0, green: 159.0/255.0, blue: 76.0/255.0, alpha: 1.0)
        case "ground":
            return UIColor(colorLiteralRed: 202.0/255.0, green: 182.0/255.0, blue: 112.0/255.0, alpha: 1.0)
        case "ice":
            return UIColor(colorLiteralRed: 109.0/255.0, green: 214.0/255.0, blue: 204.0/255.0, alpha: 1.0)
        case "normal":
            return UIColor(colorLiteralRed: 123.0/255.0, green: 129.0/255.0, blue: 133.0/255.0, alpha: 1.0)
        case "poison":
            return UIColor(colorLiteralRed: 217.0/255.0, green: 76.0/255.0, blue: 189.0/255.0, alpha: 1.0)
        case "psychic":
            return UIColor(colorLiteralRed: 255.0/255.0, green: 100.0/255.0, blue: 99.0/255.0, alpha: 1.0)
        case "rock":
            return UIColor(colorLiteralRed: 206.0/255.0, green: 109.0/255.0, blue: 62.0/255.0, alpha: 1.0)
        case "steel":
            return UIColor(colorLiteralRed: 43.0/255.0, green: 132.0/255.0, blue: 146.0/255.0, alpha: 1.0)
        case "water":
            return UIColor(colorLiteralRed: 91.0/255.0, green: 178.0/255.0, blue: 217.0/255.0, alpha: 1.0)
        default:
            print("type not found")
            return UIColor.red
        }
    }
    
}
