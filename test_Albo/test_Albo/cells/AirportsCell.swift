//
//  AirportsCell.swift
//  test_Albo
//
//  Created by Claudia Isamar Delgado Vásquez on 07/06/21.
//

import UIKit

class AirportsCell: UITableViewCell {

    let bgView: UIView = {
        let bg = UIView()
        bg.backgroundColor = .white
        return bg
    }()

    let leftView: UIView = {
        let bg = UIView()
        bg.backgroundColor = UIColor.Airport.blue
        return bg
    }()
    
    let nameLb: UILabel = {
        let lb = UILabel()
        lb.textColor = .black
        lb.font = UIFont(name: "Roboto-Regular", size: 16)
        lb.textAlignment = .left
        return lb
    }()
    
    let codeLb: UILabel = {
        let lb = UILabel()
        lb.textColor = .black
        lb.font = UIFont(name: "Roboto-Regular", size: 18)
        lb.textAlignment = .left
        return lb
    }()
    
    let stackView: UIStackView = {
       let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .fill
        sv.distribution = .fillEqually
        sv.spacing = 0
        return sv
    }()
    let bottomView: UIView = {
        let bg = UIView()
        bg.backgroundColor = UIColor.Airport.grayTitle
        return bg
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addViews()
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews(){
        //add elementos tu view:
        addSubview(bgView)
        
        bgView.addSubview(leftView)
        bgView.addSubview(stackView)
        bgView.addSubview(bottomView)
        
        //
        stackView.addArrangedSubview(nameLb)
        stackView.addArrangedSubview(codeLb)
        
    }
    
    func setupViews(){
        //add actions to elements:
        
    }
    
    func setupLayout(){
        //add sizeConstraint to elements:
        bgView.translatesAutoresizingMaskIntoConstraints = true
        stackView.translatesAutoresizingMaskIntoConstraints = true
        bottomView.translatesAutoresizingMaskIntoConstraints = true
        
        bgView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        //bgView.heightAnchor.constraint(equalToConstant: 75).isActive = true
        
        leftView.anchor(top: bgView.topAnchor, leading: bgView.leadingAnchor, bottom: bottomView.topAnchor, trailing: stackView.leadingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5))
        leftView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        
        stackView.anchor(top: bgView.topAnchor, leading: leftView.trailingAnchor, bottom: bottomView.topAnchor, trailing: bgView.trailingAnchor, padding: UIEdgeInsets(top: 15, left: 5, bottom: 15, right: 5))
        
        bottomView.anchor(top: nil, leading: bgView.leadingAnchor, bottom: bgView.bottomAnchor, trailing: bgView.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        bottomView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
    }

}
