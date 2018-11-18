//
//  ViewController.swift
//  MapIT
//
//  Created by Mikhail Lutskiy on 17/11/2018.
//  Copyright © 2018 Mikhail Lutskii. All rights reserved.
//

import UIKit
import NMAKit
import ObjectMapper
import CoreLocation


class ViewController: UIViewController, NMAMapViewDelegate, UIPopoverPresentationControllerDelegate {
    @IBOutlet weak var viewForSearch: UIView!
    
    var arrayOfBicycle = [NMAMapCircle]()
    var arrayOfPublicTransport = [NMAMapCircle]()
    var arrayOfPollutionTransport = [NMAMapCircle]()
    var arrayOfParkingPolygons = [NMAMapPolygon]()
    var arrayOfGreenPolygons = [NMAMapPolygon]()

    @IBOutlet weak var mapView: NMAMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewForSearch.layer.borderColor = UIColor.MapItColor.cgColor
        viewForSearch.layer.borderWidth = 2
        mapView.set(geoCenter: NMAGeoCoordinates(latitude: 50.049683, longitude: 19.944544), animation: .linear)
        mapView.delegate = self
//        showBicycle()
//        showBusStops()
//        showParking()
//        showGreen()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mapView.remove(mapObjects: arrayOfBicycle)
        mapView.remove(mapObjects: arrayOfPublicTransport)
        mapView.remove(mapObjects: arrayOfPollutionTransport)
        mapView.remove(mapObjects: arrayOfParkingPolygons)
        mapView.remove(mapObjects: arrayOfGreenPolygons)
        arrayOfBicycle = [NMAMapCircle]()
        arrayOfPublicTransport = [NMAMapCircle]()
        arrayOfParkingPolygons = [NMAMapPolygon]()
        arrayOfGreenPolygons = [NMAMapPolygon]()
        arrayOfPollutionTransport = [NMAMapCircle]()
        showPollution()
        showBicycle()
        showBusStops()
        showParking()
        showGreen()
        calculate()
    }
    
    func showPollution() {
        let jsonData = try! String(contentsOfFile: Bundle.main.path(forResource: "airly", ofType: "json")!)
        let data = Mapper<ArrayForModel>().map(JSONString: jsonData)
        let cl = NMAClusterLayer()
        for pin in (data?.features)! {
            //            let mm = NMAMapMarker(geoCoordinates: NMAGeoCoordinates(latitude: (pin.geometry?.y)!, longitude: (pin.geometry?.x)!), image: #imageLiteral(resourceName: "bicycle_marker"))
            //            cl.addMarker(mm)
            
            let circle = NMAMapCircle(NMAGeoCoordinates(latitude: (pin.geometry?.y)!, longitude: (pin.geometry?.x)!), radius: pin.attributes!.pollution!)
            circle.fillColor = UIColor(rgb: 0xFF7C7C, alpha: 0.8)
            self.arrayOfPollutionTransport.append(circle)
            //            mapView.add(mapObject: circle)
        }
        self.mapView.add(clusterLayer: cl)
        self.mapView.add(mapObjects: self.arrayOfPollutionTransport)
    }
    
    func showBicycle() {
        let jsonData = try! String(contentsOfFile: Bundle.main.path(forResource: "bike", ofType: "json")!)
        let data = Mapper<ArrayForModel>().map(JSONString: jsonData)
        let cl = NMAClusterLayer()
        for pin in (data?.features)! {
//            let mm = NMAMapMarker(geoCoordinates: NMAGeoCoordinates(latitude: (pin.geometry?.y)!, longitude: (pin.geometry?.x)!), image: #imageLiteral(resourceName: "bicycle_marker"))
//            cl.addMarker(mm)
            
            let circle = NMAMapCircle(NMAGeoCoordinates(latitude: (pin.geometry?.y)!, longitude: (pin.geometry?.x)!), radius: SearchManager.shared.bicycleM)
            self.arrayOfBicycle.append(circle)
            //            mapView.add(mapObject: circle)
        }
        self.mapView.add(clusterLayer: cl)
        self.mapView.add(mapObjects: self.arrayOfBicycle)
    }
    
    func showBusStops() {
        let jsonData = try! String(contentsOfFile: Bundle.main.path(forResource: "public_transport", ofType: "json")!)
        let data = Mapper<ArrayForModel>().map(JSONString: jsonData)
        let cl = NMAClusterLayer()
        for pin in (data?.features)! {
//            let mm = NMAMapMarker(geoCoordinates: NMAGeoCoordinates(latitude: (pin.geometry?.y)!, longitude: (pin.geometry?.x)!), image: #imageLiteral(resourceName: "bus_marker"))
//            cl.addMarker(mm)
            
            let circle = NMAMapCircle(NMAGeoCoordinates(latitude: (pin.geometry?.y)!, longitude: (pin.geometry?.x)!), radius: SearchManager.shared.publicTransportM)
            circle.fillColor = .PublicTransport
            arrayOfPublicTransport.append(circle)
//            mapView.add(mapObject: circle)
        }
        mapView.add(clusterLayer: cl)
        mapView.add(mapObjects: arrayOfPublicTransport)

    }
    
    func showParking() {
        let jsonData = try! String(contentsOfFile: Bundle.main.path(forResource: "parking", ofType: "json")!)
        let data = Mapper<ArrayForModel>().map(JSONString: jsonData)
        for feature in (data?.features)! {
            let geometry = feature.geometry?.rings?.first
//            let polygon = NMAMapPolygon(polygon: NMAGeoPolygon())
            var coordinates = [NMAGeoCoordinates]()
            for pin in geometry! {
                coordinates.append(NMAGeoCoordinates(latitude: pin.last!, longitude: pin.first!))
            }
            let polygon = NMAMapPolygon(vertices: coordinates)
            arrayOfParkingPolygons.append(polygon)
            //mapView.add(mapObject: polygon)
        }
        mapView.add(mapObjects: arrayOfParkingPolygons)
    }

    func showGreen() {
        let jsonData = try! String(contentsOfFile: Bundle.main.path(forResource: "green", ofType: "json")!)
        let data = Mapper<ArrayForModel>().map(JSONString: jsonData)
        for feature in (data?.features)! {
            let geometry = feature.geometry?.rings?.first
            //            let polygon = NMAMapPolygon(polygon: NMAGeoPolygon())
            var coordinates = [NMAGeoCoordinates]()
            for pin in geometry! {
                coordinates.append(NMAGeoCoordinates(latitude: pin.last!, longitude: pin.first!))
            }
            let polygon = NMAMapPolygon(vertices: coordinates)
            polygon.fillColor = .green
            arrayOfGreenPolygons.append(polygon)
            //mapView.add(mapObject: polygon)
        }
        mapView.add(mapObjects: arrayOfGreenPolygons)
    }
    
    func calculate() {
        for latitude in stride(from: 49.969212, to: 50.103863, by: 0.0500) {
            for longitude in stride(from: 19.775814, to: 20.060458, by: 0.0500) {
                let distanceCount = distance(latitude: latitude, longitude: longitude)
                print(distanceCount)
                if distance(latitude: latitude, longitude: longitude) > 2 {
                    let pin = NMAMapMarker(geoCoordinates: NMAGeoCoordinates(latitude: latitude, longitude: longitude), image: #imageLiteral(resourceName: "home_marker"))
                    
//                    let circle = NMAMapMarker(geoCoordinates: NMAGeoCoordinates(latitude: latitude, longitude: longitude))
                    self.mapView.add(mapObject: pin)
                }
//                arrayOfPublicTransport.append(circle)
                
//                distance(latitude: latitude, longitude: longitude)
//                print(latitude)
//                print(longitude)
            }
        }
    }
    
    func distance (latitude: Double, longitude: Double) -> Int {
        var counter = 0
        var jsonData = try! String(contentsOfFile: Bundle.main.path(forResource: "bike", ofType: "json")!)
        var data = Mapper<ArrayForModel>().map(JSONString: jsonData)
        for pin in (data?.features)! {
            let coord1 = CLLocation(latitude: latitude, longitude: longitude)
            let coord2 = CLLocation(latitude: (pin.geometry?.y)!, longitude: (pin.geometry?.x)!)
//            print("calc \(coord1.distance(from: coord2))")
            if coord1.distance(from: coord2) < SearchManager.shared.bicycleM {
                counter += 1
            }
        }
        
        jsonData = try! String(contentsOfFile: Bundle.main.path(forResource: "public_transport", ofType: "json")!)
        data = Mapper<ArrayForModel>().map(JSONString: jsonData)
        for pin in (data?.features)! {
            let coord1 = CLLocation(latitude: latitude, longitude: longitude)
            let coord2 = CLLocation(latitude: (pin.geometry?.y)!, longitude: (pin.geometry?.x)!)
//            print("calc2 \(coord1.distance(from: coord2))")
            if coord1.distance(from: coord2) < SearchManager.shared.publicTransportM {
                counter += 1
            }
        }
        return counter
    }
    
    func mapView(_ mapView: NMAMapView, didSelect objects: [NMAViewObject]) {
        for pin in objects {
            if let marker = pin as? NMAMapMarker {
                print(marker)
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "LocationVC") as! LocationVC
                vc.coord = marker.coordinates
                //        vc.location = marker.locationModel
                //        vc.user = data[indexPath.row]
                //        vc.doneCount = user.doneCount
                //        vc.rating = user.rating
                
                let nav = UINavigationController(rootViewController: vc)
                nav.modalPresentationStyle = .popover
                //print(self.view.frame.size.width)
                //print(self.view.frame.size.height)
                nav.preferredContentSize = CGSize(width: self.view.frame.size.width - 20, height: self.view.frame.size.height - 50)
                
                let ppc = nav.popoverPresentationController
                ppc?.permittedArrowDirections = UIPopoverArrowDirection.init(rawValue: 0)
                ppc?.delegate = self
                ppc?.sourceView = self.view
                
                present(nav, animated: true, completion: nil)
                break
            }
        }
    
    }

    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
}

