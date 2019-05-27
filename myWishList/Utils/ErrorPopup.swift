//
//  Popup.swift
//  myWishList
//
//  Created by MacBook on 5/25/19.
//  Copyright © 2019 Apptive. All rights reserved.
//

import UIKit

class ErrorPopup: UIView {
    
    let errorLabel:UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "item already exist in wish list"
        return label
    }()
    
    let containerView:UIView = {
        let contanier = UIView()
        contanier.translatesAutoresizingMaskIntoConstraints = false
        contanier.backgroundColor = .white
        return contanier
    }()
    
    let okButton:UIButton = {
        let ok = UIButton()
        ok.translatesAutoresizingMaskIntoConstraints = false
        ok.setTitle("Ok", for: .normal)
        ok.setTitleColor(.blue, for: .normal)
        ok.addTarget(self, action: #selector(okTapped), for: .touchUpInside)
        return ok
    }()
    
    var delegate : PopupDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubViews(in: self)
        self.frame = UIScreen.main.bounds
        self.backgroundColor = .lightGray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    fileprivate func configureSubViews(in view:UIView){
        let stackView = UIStackView(arrangedSubviews: [errorLabel,okButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
       
    }
    
    
    // MARK: - Selectors
    @objc fileprivate func okTapped(){
        delegate?.handlePopupDismiss()
    }
    
}
