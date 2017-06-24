//
//  MapsViewController.swift
//  NotesApp
//
//  Created by HSIAO JENHAO on 2016-12-11.
//  Copyright © 2016 Jenhao.ca. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation
import MapKit




class MapsViewController: UIViewController, GMSMapViewDelegate {


    var MapLatitude:Double? = 0
    var MapLongitude:Double? = 0

    var MapGetLatitude:Double? = nil
    var MapGetLongitude:Double? = nil

    var MapTitle = "Lambton College"
    var MapSnippet = "Toronto"

    @IBOutlet weak var MapShow: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        GMSServices.provideAPIKey("AIzaSyBixHPv6-l0CU7KheNkmKx9Mrh86M9_2CY")

        MapLatitude = MapGetLatitude
        MapLongitude = MapGetLongitude





        let camera = GMSCameraPosition.camera(withLatitude: MapLatitude!,
                                              longitude: MapLongitude!, zoom: 6)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)

        mapView.delegate = self

        mapView.accessibilityElementsHidden = false
        mapView.settings.compassButton = true
        mapView.settings.myLocationButton = true


        mapView.setMinZoom(13, maxZoom: 20)
        mapView.mapType = kGMSTypeNormal
        
        mapView.isMyLocationEnabled = true
        self.view = mapView

        let marker = GMSMarker()



        marker.position = CLLocationCoordinate2DMake(MapLatitude!, MapLongitude!)
        marker.title = MapTitle
        marker.snippet = MapSnippet
        marker.map = mapView

        // The myLocation attribute of the mapView may be null
        if let mylocation = mapView.myLocation {
            print("User's location: \(mylocation)")
        } else {
            print("User's location is unknown")
        }

    }

    func mapView(mapView: GMSMapView!, didTapAtCoordinate coordinate: CLLocationCoordinate2D) {
        print("You tapped at \(coordinate.latitude), \(coordinate.longitude)")
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }







}
