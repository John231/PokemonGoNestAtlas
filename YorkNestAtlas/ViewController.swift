//
//  ViewController.swift
//  YorkNestAtlas
//
//  Created by Jonathan Bones on 04.06.17.
//  Copyright © 2017 Jonathan Bones. All rights reserved.
//

import UIKit

//Neccessary for loading MKMapView
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!//MapView
    
    var nests = [PokeNest]()
    let pokeNest = PokeNest(pokemonName: "", pokedexEntry: 0, pokemonType: "", coordinate: CLLocationCoordinate2DMake(10, 10), nestVerified: false)
    
    enum ReadError: Error {
        case fileNotFound(String)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set initial map location to York
        let initialLocation = CLLocation(latitude: 53.960024, longitude: -1.087152)
        
        let regionRadius: CLLocationDistance = 1000
        
        func centerMapOnLocation(location: CLLocation){
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius*2.0, regionRadius*2.0)
            mapView.setRegion(coordinateRegion, animated: true)
        }
        
        centerMapOnLocation(location: initialLocation)
        
        mapView.delegate = self
        
        try? loadInitialData()
        mapView.addAnnotations(nests)
    }
    
    //Helper function to load initial data
    func loadInitialData() throws {
        let fileName = Bundle.main.path(forResource: "NestData", ofType: "json")
        var jsonData: Data = Data()
    
        if let locatedFile = fileName {
            jsonData = try Data(contentsOf: URL(fileURLWithPath: locatedFile))
        }
        
        if let allNests = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any]{
            if let nests = allNests["nest"] as? [[String: Any]]{
                //Cycle through nest entries and access elements
                for jsonNest in nests{
                    self.nests.append(pokeNest.extractNestsFromJSON(json: jsonNest))
                }
            }

        }
        
    }
}

