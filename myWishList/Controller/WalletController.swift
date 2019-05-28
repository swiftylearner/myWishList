//
//  WalletController.swift
//  myWishList
//
//  Created by MacBook on 5/25/19.
//  Copyright © 2019 Apptive. All rights reserved.
//

import UIKit

class WalletController: UIViewController {
    
    lazy var amountTextField:UITextField = {
        let amount = UITextField()
        amount.custom(placeHolder: "$0", size: 60)
        return amount
    }()
    
    lazy var addButton:UIButton = {
        let add = UIButton()
        add.translatesAutoresizingMaskIntoConstraints = false
        add.setTitle("Add", for: .normal)
        add.setTitleColor(.white, for: .normal)
        add.backgroundColor = .blue
        add.addTarget(self, action: #selector(addMoneyToWallet), for: .touchUpInside)
        return add
    }()
    
    lazy var backButton:UIButton = {
        let back = UIButton()
        back.translatesAutoresizingMaskIntoConstraints = false
        back.addTarget(self, action: #selector(goBackToItemController), for: .touchUpInside)
        back.setImage(UIImage(named: "back")?.withRenderingMode(.alwaysOriginal), for: .normal)
        return back
    }()
    
    lazy var descriptionLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Add money to your wallet"
        label.textAlignment = .center
        return label
    }()
    
    lazy var backgroundImage:UIImageView = {
        let imagView = UIImageView()
        imagView.configure(image: "money")
        return imagView
    }()

    var delegate : WalletDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureViews()
        
    }
    
    fileprivate func configureViews(){
        view.addSubview(backgroundImage)
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leftAnchor.constraint(equalTo: view.leftAnchor),
            backgroundImage.rightAnchor.constraint(equalTo: view.rightAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        let stackView = UIStackView(arrangedSubviews: [amountTextField,addButton,descriptionLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            
            amountTextField.heightAnchor.constraint(equalToConstant: 50),
            addButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        view.addSubview(backButton)
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            backButton.leftAnchor.constraint(equalTo: addButton.leftAnchor),
            backButton.heightAnchor.constraint(equalToConstant: 50),
        ])
        
    
    }
    
    // MARK: - Selectors
    @objc fileprivate func goBackToItemController(){
        dismiss(animated: true, completion: nil)
    }

    @objc fileprivate func addMoneyToWallet(){
        guard let amount = Double(amountTextField.text!) else {return}
        delegate?.handleAmountOfMoney(added: amount)
        dismiss(animated: true, completion: nil)
    }

}
