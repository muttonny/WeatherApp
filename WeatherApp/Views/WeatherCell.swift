//
//  WeatherCell.swift
//  WeatherApp
//
//  Created by Tony Mut on 10/7/22.
//

import UIKit
import SwiftUI

class WeatherCell : UICollectionViewCell{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        addSubview(svCell)
    }
    
    var dayField : UILabel = {
        let tf = UILabel()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.text = "Monday"
        tf.font = UIFont.systemFont(ofSize: 20)
        tf.textColor = .white
        return tf;
    }()
    
    var tempField : UILabel = {
        let tf = UILabel()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.text = "20"
        tf.textAlignment = .right
        tf.font = UIFont.boldSystemFont(ofSize: 18)
        tf.textColor = .white
        return tf;
    }()
    
    var image: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "clear")
        img.contentMode = .scaleAspectFit
        img.clipsToBounds = true
        return img
    }()
    
    lazy var svCell: UIStackView = {
        
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        sv.addArrangedSubview(dayField)
        sv.addArrangedSubview(image)
        sv.addArrangedSubview(tempField)
        //sv.backgroundColor = .yellow
        return sv
    }()
    
    func addConstraints(){
        
        NSLayoutConstraint.activate([
        
//            dayField.topAnchor.constraint(equalTo: topAnchor, constant: 0.0),
//            dayField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.0),
            
            image.widthAnchor.constraint(equalToConstant: CGFloat(28.0)),
            image.heightAnchor.constraint(equalToConstant: CGFloat(28)),
            
            svCell.topAnchor.constraint(equalTo: topAnchor, constant: 0.0),
            svCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.0),
            svCell.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20.0),
            //svCell.widthAnchor.constraint(equalTo: widthAnchor),
//            svCell.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        ])
    }
    
}
