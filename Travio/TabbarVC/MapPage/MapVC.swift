//
//  MapVC.swift
//  AccessTokenApi
//
//  Created by Kullanici on 18.08.2023.


import UIKit
import MapKit
import TinyConstraints
import CoreLocation
import NVActivityIndicatorView
protocol Reloader: AnyObject {
    func reload()
}

class MapVC: UIViewController, CLLocationManagerDelegate{
   
    let viewModal = MapVM()

    let addTravelVC = AddTravelVC()
    
    let locationManager = CLLocationManager()

    private lazy var activity: NVActivityIndicatorView = {
        let activity = NVActivityIndicatorView(frame: .zero, type: .pacman, color: Color.systemGreen.chooseColor, padding: 0)
        return activity
    }()
    
    private lazy var mapView: MKMapView = {
        let mv = MKMapView()
        mv.mapType = MKMapType.standard
        mv.isZoomEnabled = true
        mv.isScrollEnabled = true
        mv.delegate = self
        return mv
    }()
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 18
        flowLayout.minimumInteritemSpacing = 18
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        let cv = UICollectionView(frame: .zero,collectionViewLayout: flowLayout)
        cv.register(MapCollectionCell.self, forCellWithReuseIdentifier: "map")
        cv.delegate = self
        cv.dataSource = self
        cv.isPagingEnabled = false
        cv.showsHorizontalScrollIndicator = false
        cv.contentInsetAdjustmentBehavior = .never
        cv.backgroundColor = .clear
        cv.layoutIfNeeded()
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationAdjustment()
        setupView()
        initVM()
        
        longPress()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @objc func handleLongPress(sender: UILongPressGestureRecognizer) {
        
        if sender.state == .began {
                   let touchPoint = sender.location(in: mapView)
                   let touchCoordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)

                   let vc = AddTravelVC()
                   vc.latitude = touchCoordinate.latitude
                   vc.longitude = touchCoordinate.longitude
                   vc.delegate = self
                   present(vc, animated: true)
               }
        
    }

    
    func locationAdjustment() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.startMonitoringVisits()
    }
    
    func longPress() {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        mapView.addGestureRecognizer(longPressGesture)
    }
    
    func initVM() {
        activity.startAnimating()
        viewModal.getLocations() { status, message in
            if !status {
                AlertHelper.showAlert(in: self, title: .sorry , message: message, primaryButtonTitle: .ok, primaryButtonAction: nil, secondaryButtonTitle: nil, secondaryButtonAction: nil)
            }
            
        }
        
        viewModal.fillMapp = { locations in
            self.configure(locations: locations)
        }
        
        viewModal.reloadCell = {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.activity.stopAnimating()
            }
        }
        
    }
    
    func configure(locations: [PlaceItem]) {
        for location in locations {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            annotation.title = location.title
            mapView.addAnnotation(annotation)
        }
    }
    
    private func setupView() {
        self.view.backgroundColor = Color.systemGreen.chooseColor
        view.addSubViews(mapView,collectionView, activity)
        setupLayout()
    }
    
    private func setupLayout() {
        mapView.edgesToSuperview()
        
        collectionView.edgesToSuperview(excluding: [.top], insets: .bottom(101))
        collectionView.height(178)
        
        activity.centerInSuperview()
        activity.height(40)
        activity.width(40)
    }
    
    func pushNav(item: PlaceItem) {
        let detailVC = DetailVC()
        detailVC.placeId = item.id
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}


extension MapVC: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let customAnnotation = view.annotation as? MKPointAnnotation {
            let region = MKCoordinateRegion(center: customAnnotation.coordinate, latitudinalMeters: 3000, longitudinalMeters: 3000)
            mapView.setRegion(region, animated: false)
            guard let collectionData = viewModal.getAllArray() else {return}
            if let index = collectionData.firstIndex(of: customAnnotation.title ?? "") {
                let indexPath = IndexPath(item: index, section: 0)
                collectionView.scrollToItem(at: indexPath, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? MKAnnotation else {
            return nil
        }
        
        let identifier = "customAnnotation"
        var annotationView: MKAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) {
            dequeuedView.annotation = annotation
            annotationView = dequeuedView
        } else {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView.canShowCallout = true
            annotationView.image = UIImage(named: "mapIcon")
        }
        return annotationView
    }
    
}


extension MapVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: 309, height: (collectionView.frame.height))
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = viewModal.getObjectForRow(indexpath: indexPath) else {return}
        pushNav(item: item)
    }
    
}

extension MapVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModal.NumberOfRows()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "map", for: indexPath) as? MapCollectionCell else {return UICollectionViewCell()}
        guard let object = viewModal.getObjectForRow(indexpath: indexPath) else { return cell}
        cell.configure(item: object)
        return cell
    }
    
}

extension MapVC: Reloader {
    
    func reload() {
        initVM()
    }
    
}
