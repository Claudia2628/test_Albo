//
//  BottonBar.swift
//  test_Albo
//
//  Created by Claudia Isamar Delgado Vásquez on 07/06/21.
//

import UIKit


class BottonBar: UIView {

    let mapView = UIView()
    
    let listView = UIView()
    
    let mapImg = UIImageView()
    
    let listImg = UIImageView()
    
    let stackBtn = UIStackView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addViews()
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews(){
        //add elementos tu view:
        self.backgroundColor = UIColor.Airport.mainGray
        
        self.addSubview(stackBtn)
        
        self.stackBtn.addArrangedSubview(mapView)
        self.mapView.addSubview(mapImg)
        
        self.stackBtn.addArrangedSubview(listView)
        self.listView.addSubview(listImg)
    }
    
    func setupViews(){
        //add actions to elements:
        mapView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTappedMap)))
        listView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTappedList)))
        
        //
        mapImg.image = UIImage(named: "iconPin")
        mapImg.contentMode = .scaleAspectFit
        //
        listImg.image = UIImage(named: "iconList")
        listImg.contentMode = .scaleAspectFit
        
        //
        stackBtn.axis = .horizontal
        stackBtn.alignment = .fill
        stackBtn.distribution = .fillEqually
        stackBtn.spacing = 0
    }
    
    private func setupLayout(){
        //add sizeConstraint to elements:
        stackBtn.translatesAutoresizingMaskIntoConstraints = false
        mapImg.translatesAutoresizingMaskIntoConstraints = false
        listImg.translatesAutoresizingMaskIntoConstraints = false
        
        mapImg.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        mapImg.heightAnchor.constraint(equalToConstant: 30).isActive = true
        mapImg.widthAnchor.constraint(equalToConstant: 30).isActive = true
        mapImg.centerXAnchor.constraint(equalTo: mapView.centerXAnchor).isActive = true
        mapImg.centerYAnchor.constraint(equalTo: mapView.centerYAnchor).isActive = true
        
        listImg.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        listImg.heightAnchor.constraint(equalToConstant: 30).isActive = true
        listImg.widthAnchor.constraint(equalToConstant: 30).isActive = true
        listImg.centerXAnchor.constraint(equalTo: listView.centerXAnchor).isActive = true
        listImg.centerYAnchor.constraint(equalTo: listView.centerYAnchor).isActive = true
        
        stackBtn.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        //stackBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    @objc func onTappedMap(){
        print("Show Map")
       
    }
    
    @objc func onTappedList(){
        print("Show List")
       
    }
    
    func setImg(statusMap: Bool){
        
        if statusMap == true {
            //
            mapImg.image = UIImage(named: "iconPin")
            //
            listImg.image = UIImage(named: "iconList_white")
        
        } else {
            //
            mapImg.image = UIImage(named: "iconPin_white")
            //
            listImg.image = UIImage(named: "iconList")
        }
    }
}
