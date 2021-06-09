//
//  RadiusFinderViewController.swift
//  test_Albo
//
//  Created by Claudia Isamar Delgado Vásquez on 07/06/21.
//

import UIKit
import CoreLocation

class RadiusFinderViewController: UIViewController, CLLocationManagerDelegate {

    let titleLb: UILabel = {
        let lb = UILabel()
        lb.text = "AIRPORT"
        lb.font = UIFont(name: "Roboto-Bold", size: 50)
        lb.textColor = .white
        lb.textAlignment = .center
        return lb
    }()
    
    let subtitleLb: UILabel = {
        let lb = UILabel()
        lb.text = "finder"
        lb.font = UIFont(name: "Roboto-Regular", size: 30)
        lb.textColor = .white
        lb.textAlignment = .center
        return lb
    }()
    
    let radiusSelectedLb: UILabel = {
        let lb = UILabel()
        lb.text = "0"
        lb.font = UIFont(name: "Roboto-Bold", size: 40)
        lb.textColor = UIColor.Airport.grayTitle
        lb.textAlignment = .center
        return lb
    }()
    
    let sliderSearch: UISlider = {
        let sl = UISlider()
        sl.minimumValue = 0
        sl.maximumValue = 100
        sl.maximumTrackTintColor = .white
        sl.minimumTrackTintColor = UIColor.Airport.blue
        sl.thumbTintColor = .white
        return sl
    }()
    
    let radiusLb: UILabel = {
        let lb = UILabel()
        lb.text = " RADIUS IN KM"
        lb.font = UIFont(name: "Roboto-Bold", size: 16)
        lb.textColor = UIColor.Airport.grayTitle
        lb.textAlignment = .center
        return lb
    }()
    
    let searchBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("SEARCH", for: .normal)
        btn.titleLabel?.textColor = .white
        btn.backgroundColor = UIColor.Airport.blue
        btn.layer.cornerRadius = 10
        btn.layer.masksToBounds = false
        btn.layer.shadowColor = UIColor.Airport.grayTitle.cgColor
        btn.layer.shadowOpacity = 1
        btn.layer.shadowRadius = 10
        return btn
    }()
    
    
    var locationManager: CLLocationManager!
    
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.Airport.mainGray
        
        addViews()
        setupViews()
        setupLayout()
        
        setupDatas()
    }
    
    private func addViews(){
        view.addSubview(titleLb)
        view.addSubview(subtitleLb)
        view.addSubview(radiusSelectedLb)
        view.addSubview(sliderSearch)
        view.addSubview(radiusLb)
        view.addSubview(searchBtn)
        
    }
    
    private func setupViews(){
        //add actions to elements:
        sliderSearch.addTarget(self, action: #selector(onSliderChanged), for: .valueChanged)
        searchBtn.addTarget(self, action: #selector(onTappedSearch), for: .touchUpInside)
    }

    private func setupLayout(){
        titleLb.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 40, left: 25, bottom: 0, right: 25))
        titleLb.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        subtitleLb.anchor(top: titleLb.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 25, bottom: 0, right: 25))
        subtitleLb.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        radiusSelectedLb.anchor(top: nil, leading: view.leadingAnchor, bottom: sliderSearch.topAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 25, bottom: 10, right: 25))
        radiusSelectedLb.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        sliderSearch.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 5, left: 25, bottom: 0, right: 25))
        sliderSearch.heightAnchor.constraint(equalToConstant: 40).isActive = true
        sliderSearch.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        radiusLb.anchor(top: sliderSearch.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 25, bottom: 0, right: 25))
        radiusLb.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        searchBtn.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 25, bottom: 30, right: 25))
        searchBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func setupDatas(){
        
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    @objc func onSliderChanged(_ sender: UISlider){
        //print(sender.value)
        let valueSelected = Int(sender.value)
       
        self.radiusSelectedLb.text = "\(valueSelected)"
    }
    
    @objc func onTappedSearch(){
        
        //Pass to VC
        let vC = LocationsMapViewController()
        let valueS = self.radiusSelectedLb.text ?? "0"
        vC.valueRadius = Int(valueS)
        vC.latitude = self.latitude
        vC.longitude = self.longitude
        self.navigationController?.pushViewController(vC, animated: true)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation :CLLocation = locations[0] as CLLocation
        
        self.latitude = userLocation.coordinate.latitude
        self.longitude = userLocation.coordinate.longitude
    }
}
