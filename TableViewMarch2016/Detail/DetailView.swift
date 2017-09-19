//
//  DetailView.swift
//  TableViewMarch2016
//
//  Created by dasdom on 28.03.16.
//  Copyright © 2016 dasdom. All rights reserved.
//

import UIKit

class DetailView: UIView {

  let nameLabel: UILabel
  let descriptionLabel: UILabel
  let stackView: UIStackView
  
  override init(frame: CGRect) {
    nameLabel = UILabel()
    nameLabel.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.title1)
    nameLabel.textAlignment = .center
    
    descriptionLabel = UILabel()
    descriptionLabel.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
    descriptionLabel.numberOfLines = 2
    descriptionLabel.textAlignment = .center
    
    stackView = UIStackView(arrangedSubviews: [nameLabel, descriptionLabel])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.spacing = 5
    
    super.init(frame: frame)
    
    addSubview(stackView)
    
    let views = ["stackView": stackView]
    var layoutConstraints = [NSLayoutConstraint]()
    layoutConstraints += NSLayoutConstraint.constraints(withVisualFormat: "|-[stackView]-|", options: [], metrics: nil, views: views)
    NSLayoutConstraint.activate(layoutConstraints)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
