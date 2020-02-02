//
//  DataTableViewCell.swift
//  Assesment_iOS
//
//  Created by Developer on 21/01/20.
//  Copyright © 2020 Developer. All rights reserved.
//

import UIKit

class DataTableViewCell: UITableViewCell {
    
      let tittle_Label = UILabel()
      let description_Label = UILabel()
      let product_ImageView = UIImageView()
      let seprator_View = UIView()
      
      // MARK: Initalizers
      override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
          super.init(style: style, reuseIdentifier: reuseIdentifier)
          
          let marginGuide = contentView.layoutMarginsGuide
          
          // configure imageView
          contentView.addSubview(product_ImageView)
          product_ImageView.contentMode = .scaleAspectFit
          product_ImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
          product_ImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
          product_ImageView.translatesAutoresizingMaskIntoConstraints = false
          product_ImageView.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor, constant: 10).isActive = true
          product_ImageView.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true

          // configure titleLabel
          contentView.addSubview(tittle_Label )
          tittle_Label .translatesAutoresizingMaskIntoConstraints = false

          tittle_Label .leadingAnchor.constraint(equalTo: product_ImageView.trailingAnchor, constant: 10).isActive = true
          tittle_Label .topAnchor.constraint(equalTo: marginGuide.topAnchor,constant: 20).isActive = true
          tittle_Label .trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
          tittle_Label .numberOfLines = 0
          tittle_Label .font = UIFont(name: "AvenirNext-DemiBold", size: 16)
          
          // configure authorLabel
          contentView.addSubview(description_Label)
          description_Label.translatesAutoresizingMaskIntoConstraints = false
          description_Label.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor,constant: 10).isActive = true
          description_Label.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
          description_Label.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
          description_Label.topAnchor.constraint(equalTo: product_ImageView.bottomAnchor,constant: 15).isActive = true
          description_Label.numberOfLines = 0
          description_Label.font = UIFont(name: "Avenir-Book", size: 12)
          description_Label.textColor = UIColor.gray
        
      }
      
      required init?(coder aDecoder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }
    

}
