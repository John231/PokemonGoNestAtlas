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
    
    enum ReadError: Error {
        case fileNotFound(String)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadInitialData()
        
        //Set initial map location to York
        let initialLocation = CLLocation(latitude: 53.960024, longitude: -1.087152)
        
        let regionRadius: CLLocationDistance = 1000
        
        func centerMapOnLocation(location: CLLocation){
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius*2.0, regionRadius*2.0)
            mapView.setRegion(coordinateRegion, animated: true)
        }
        
        centerMapOnLocation(location: initialLocation)
        
        mapView.delegate = self
        
        let nest = PokeNest(pokemonName: "Exeggcute", pokedexEntry: 102, coordinate: CLLocationCoordinate2D(latitude: 53.961350, longitude: -1.088290), nestVerified: true)
        mapView.addAnnotation(nest)
    }
    
    //Helper function to load initial data
    func loadInitialData(){
        let filePath = Bundle.main.path(forResource: "NestData", ofType: "json")
        let contentData = FileManager.default.contents(atPath: filePath!)
        let content = NSString(data: contentData!, encoding: String.Encoding.utf8.rawValue) as String?
        print(content!)
        
        print(JSONSerialization.isValidJSONObject(content))
    }
}

