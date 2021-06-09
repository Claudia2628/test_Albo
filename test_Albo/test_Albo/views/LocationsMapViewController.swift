//
//  LocationsMapViewController.swift
//  test_Albo
//
//  Created by Claudia Isamar Delgado Vásquez on 07/06/21.
//

import UIKit
import MapKit

class LocationsMapViewController: UIViewController {
    
    var backBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("BACK", for: .normal)
        btn.backgroundColor = .black
        btn.titleLabel?.textColor = .white
        btn.layer.cornerRadius = 5
        btn.layer.masksToBounds = false
        return btn
    }()
    var mapView: MKMapView = {
        let map = MKMapView()
        return map
    }()
    
    let tableV = UITableView()
    
    
    var bottomV = BottonBar()
    
    
    
    var valueRadius: Int? = 0
    var longitude: Double? = 0.0
    var latitude: Double? = 0.0
    
    var listAirpot: [Airports] = []
    
    let _HUD = JGProgressHUD(style: JGProgressHUDStyle.dark)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.Airport.mainGray
        
        addViews()
        setupViews()
        setupLayout()
        
        setupDatas()
    }
    
    private func addViews(){
        //add elementos tu view:
        view.addSubview(backBtn)
        view.addSubview(mapView)
        view.addSubview(tableV)
        view.addSubview(bottomV)
    }
    
    private func setupViews(){
        //
        backBtn.addTarget(self, action: #selector(onTappedBack), for: .touchUpInside)
        bottomV.listView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTappedList)))
        bottomV.mapView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTappedMap)))
        
        //
        let center = CLLocationCoordinate2DMake(self.latitude ?? 0, self.longitude ?? 0)
        let span = MKCoordinateSpan(latitudeDelta: 8, longitudeDelta: 8)
        let region = MKCoordinateRegion(center: center, span: span)
        
        self.mapView.setRegion(region, animated: true)
        
        self.setPinUsingMKAnnotation(location: center, name: "Your Location")
        
        self.tableV.isHidden = true
        self.mapView.isHidden = false
        self.bottomV.setImg(statusMap: true)
        
        //TV:
        tableV.delegate = self
        tableV.dataSource = self
        tableV.backgroundColor = UIColor.Airport.mainGray
        tableV.backgroundView?.backgroundColor = UIColor.Airport.mainGray
        tableV.translatesAutoresizingMaskIntoConstraints = false
        tableV.register(AirportsCell.self, forCellReuseIdentifier: "cellItem")
        //tableV.estimatedRowHeight = 100
        tableV.rowHeight = UITableView.automaticDimension
        tableV.separatorStyle = .none
    }

    private func setupLayout(){
        var guide = view.topAnchor
        var topS : CGFloat = 20
        if #available(iOS 11, *) {
            guide = view.safeAreaLayoutGuide.topAnchor
            topS = 15
        }
        
        backBtn.anchor(top: guide, leading: view.leadingAnchor, bottom: mapView.topAnchor, trailing: nil, padding: UIEdgeInsets(top: topS, left: 5, bottom: 0, right: 0))
        backBtn.heightAnchor.constraint(equalToConstant: 30).isActive = true
        backBtn.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        mapView.anchor(top: backBtn.bottomAnchor, leading: view.leadingAnchor, bottom: bottomV.topAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
        
        tableV.anchor(top: backBtn.bottomAnchor, leading: view.leadingAnchor, bottom: bottomV.topAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
        //mapView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        bottomV.anchor(top: mapView.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        bottomV.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
    }
    
    private func setupDatas(){
        
        getAirports()
        /*self.listAirpot.removeAll()
        
        self.listAirpot.append(Airports(icao: "", iata: "", name: "Op1", municipalityName: "city", location: AirportLocation(lat: 19.14727, lon: -96.18567), countryCode: "MX"))
        self.listAirpot.append(Airports(icao: "", iata: "", name: "Op1", municipalityName: "city", location: AirportLocation(lat: 19.55381, lon: -99.07465), countryCode: "MX"))
        //self.listAirpot.append(Airports(icao: "", iata: "", name: "Op1", municipalityName: "city", location: AirportLocation(lat: <#T##Double?#>, lon: <#T##Double?#>), countryCode: "MX"))
        
        
        
        for datas in self.listAirpot {
            
            let coordinate = CLLocationCoordinate2DMake(datas.location?.lat ?? 0, datas.location?.lon ?? 0)
            
            self.setPinUsingMKAnnotation(location: coordinate, name: datas.name ?? "")
            
        }
        */
        
    }
    
    
    @objc func onTappedBack(){
        self.navigationController?.popViewController(animated: true)
       
    }
    
    @objc func onTappedList(){
        print("show list")
        //show tv
        self.tableV.isHidden = false
        //no-show map
        self.mapView.isHidden = true
        self.bottomV.setImg(statusMap: false)
    }
    @objc func onTappedMap(){
        print("show map")
        //no-show tv
        self.tableV.isHidden = true
        //show map
        self.mapView.isHidden = false
        self.bottomV.setImg(statusMap: true)
        
        
    }
    
    func getAirports(){
        DispatchQueue.main.async {
            self._HUD.show(in: self.view)
        }
        
        self.listAirpot.removeAll()
        
        AirportsManager.sharedInstance.getAirports(radius: self.valueRadius, longitude: self.longitude, latitude: self.latitude, success: { (response) -> Void in
            
            DispatchQueue.main.async {
                //self._HUD.dismiss(animated: true)
                
                let data = response.items
                
                if data?.count != 0 && data != nil {
                    self.listAirpot = data!
                    
                    self.addAirports()
                    self.tableV.reloadData()
                }
                
            }
            
            
        }, failure: { (operation, error) -> Void in
            DispatchQueue.main.async {
                self._HUD.dismiss(animated: true);
                
                let alertInvalidClientId:UIAlertController = UIAlertController(title: "Aviso", message: "Favor de intentar mas tarde.", preferredStyle: UIAlertController.Style.alert)
                
                let cancelAction:UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler:nil)
                
                alertInvalidClientId.addAction(cancelAction)
                
                self.present(alertInvalidClientId, animated: true, completion: nil)
            }
        })
    }
    
    
    func addAirports(){
        for datas in self.listAirpot {
            
            let coordinate = CLLocationCoordinate2DMake(datas.location?.lat ?? 0, datas.location?.lon ?? 0)
            
            self.setPinUsingMKAnnotation(location: coordinate, name: datas.name ?? "")
            
        }
        
        DispatchQueue.main.async {
            self._HUD.dismiss(animated: true)
            
        }
    }
    
    
    func setPinUsingMKAnnotation(location: CLLocationCoordinate2D, name: String) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = name
        //let coordinateRegion = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 800, longitudinalMeters: 800)
        mapView.addAnnotation(annotation)
    }

}


extension LocationsMapViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.listAirpot.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellItem", for: indexPath) as! AirportsCell
        
        let data = self.listAirpot[indexPath.row]
        
        cell.nameLb.text = data.name
        cell.codeLb.text = data.countryCode
        
        
        tableV.separatorStyle = .none
        cell.backgroundView?.backgroundColor = UIColor.Airport.mainGray
        cell.backgroundColor = .white
        
        return cell
    }
    
    
}
