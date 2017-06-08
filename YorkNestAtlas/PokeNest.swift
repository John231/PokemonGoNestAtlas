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

class PokeNest: NSObject, MKAnnotation {
    
    //Enum for logging error messages to console
    enum SerialisationError: Error {
        case missing(String)
    }
    
    let coordinate: CLLocationCoordinate2D
    let pokemonName: String?
    let pokedexEntry: Int
    let nestVerified: Bool
    
    var title: String? {
        return pokemonName
    }
    
    var subtitle: String? {
        return String(pokedexEntry)
    }
    
    init(pokemonName: String, pokedexEntry: Int, coordinate:CLLocationCoordinate2D, nestVerified: Bool){
        self.pokemonName = pokemonName
        self.pokedexEntry = pokedexEntry
        self.coordinate = coordinate
        self.nestVerified = nestVerified
        super.init()
    }
    
    //Function to extract data from the JSON file
    func extractNestsFromJSON(json: [String: Any]) throws -> PokeNest? {
        guard let nest = json["nest"] as? [String:Any] else {
           throw SerialisationError.missing("nest")
        }
        
        guard let latitude = nest["latitude"] as? Double, let longitude = nest["longitude"] as? Double else {
           throw SerialisationError.missing("no coordinates")
        }
        
        guard let pokemonName = nest["pokemon"] as? String, let pokedexEntry = nest["pokedexEntry"] as? Int else {
            throw SerialisationError.missing("pokemon")
        }
        
        guard let verified = nest["verified"] as? Bool  else {
            throw SerialisationError.missing("Nest Verified")
        }
        
        let nestCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        return PokeNest(pokemonName: pokemonName, pokedexEntry: pokedexEntry, coordinate: nestCoordinate, nestVerified: verified)
    }
    
    func mapItem() -> MKMapItem {
        let addressDict = [String(CNPostalAddressStreetKey): self.subtitle as AnyObject]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        
        return mapItem
    }
    
}
