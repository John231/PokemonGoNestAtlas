//
//  VCMapView.swift
//  YorkNestAtlas
//
//  Created by Jonathan Bones on 04.06.17.
//  Copyright © 2017 Jonathan Bones. All rights reserved.
//

import Foundation

import MapKit

extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? PokeNest {
            let identifier = "pin"
            var view: MKPinAnnotationView
            
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView{
                dequeuedView.annotation = annotation
                view = dequeuedView
            }
            else {
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.tintColor = UIColor(colorLiteralRed: 33.0/255.0, green: 160.0/255.0, blue: 100.0/255.0, alpha: 1.0)
                view.pinTintColor = UIColor(colorLiteralRed: 33.0/255.0, green: 160.0/255.0, blue: 100.0/255.0, alpha: 1.0)
                
                let detailButton = UIButton(type: .detailDisclosure) as UIView
                view.rightCalloutAccessoryView = detailButton
            }
            return view
        
        }
        return nil
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl){
        let location = view.annotation as! PokeNest
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking]
        location.mapItem().openInMaps(launchOptions: launchOptions)
    }
}
