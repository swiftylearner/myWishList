//
//  ViewController.swift
//  myWishList
//
//  Created by MacBook on 5/25/19.
//  Copyright © 2019 Apptive. All rights reserved.
//

import UIKit

class ItemsController: UIViewController {
    
    // MARK: - Properties
    var segmentControl:UISegmentedControl!
    var tableView:UITableView!
    lazy var gamesArray = [Items]()
    lazy var deviceArray = [Items]()
    
    lazy var itemToDisplay = gamesArray
    var wishListArray = [Items]()
    let errorPopUp = ErrorPopup()
    
    lazy var walletButton:UIButton = {
        let wallet = UIButton()
        wallet.setImage(UIImage(named: "wallet")?.withRenderingMode(.alwaysOriginal), for: .normal)
        wallet.translatesAutoresizingMaskIntoConstraints = false
        wallet.addTarget(self, action: #selector(presentWallet), for: .touchUpInside)
        return wallet
    }()
    
    lazy var descriptionLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Total: $0 "
        label.textAlignment = .center
        return label
    }()
    
    var cashAmount:Double = 0
    var totolPrice:Double = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        tableView.dataSource = self
        tableView.delegate = self
        
        // games
        gamesArray.append(Items(title: "NBA 2k19", price: "59.99"))
        gamesArray.append(Items(title: "Mortal Kombat 11", price: "60"))
        gamesArray.append(Items(title: "Fortnite", price: "49.99"))
        gamesArray.append(Items(title: "Mindcraft", price: "60"))
        
        // devices
        deviceArray.append(Items(title: "MacBook", price: "59.99"))
        deviceArray.append(Items(title: "MackBook Air", price: "1.199"))
        deviceArray.append(Items(title: "MackBook Pro", price: "1.299"))
        deviceArray.append(Items(title: "IMac", price: "1.099"))
        deviceArray.append(Items(title: "IMac Pro", price: "60"))
        deviceArray.append(Items(title: "Iphone Xr", price: "49.99"))
        deviceArray.append(Items(title: "Iphone X", price: "60"))
        
        getTotalPrice()
    }

    // MARK: - Functions
    fileprivate func configureViews(){
        segmentControl = UISegmentedControl(items: ["Games","Devices","WishList"])
        segmentControl.selectedSegmentIndex = 0
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        segmentControl.addTarget(self, action: #selector(indexForSelected(_:)), for: .valueChanged)
        
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        let stack = UIStackView(arrangedSubviews: [segmentControl,tableView])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 8
        stack.axis = .vertical
        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant:80),
            stack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            stack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            stack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ])
        
        view.addSubview(walletButton)
        NSLayoutConstraint.activate([
            walletButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 10),
            walletButton.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -10),
            walletButton.heightAnchor.constraint(equalToConstant: 50),
            walletButton.widthAnchor.constraint(equalToConstant: 60)
        ])
        
        view.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            descriptionLabel.centerYAnchor.constraint(equalTo: walletButton.centerYAnchor)
        ])
    }
    
    
    // MARK: - Selectors
    @objc fileprivate func indexForSelected(_ segment:UISegmentedControl){
        switch segment.selectedSegmentIndex {
        case 0:
            itemToDisplay = gamesArray
            configureTableViewCell()
        case 1:
            itemToDisplay = deviceArray
            configureTableViewCell()
        case 2:
            itemToDisplay = wishListArray
            tableView.allowsSelection = false
        default:
            print("no more items")
        }
        tableView.reloadData()
    }
    
    fileprivate func configureTableViewCell(){
        tableView.allowsSelection = true
        tableView.isEditing = false
    }
    
    
    @objc fileprivate func presentWallet(){
        let walletVC = WalletController()
        walletVC.delegate = self
        present(walletVC, animated: true, completion: nil)
    }
    
    // #warning("get total for each gategory")
    fileprivate func getTotalPrice() {
        let gamePriceTotal = gamesArray.reduce(0.0, {item, item2 in item + item2.price})
        let devicePriceTotal = deviceArray.reduce(0.0, {item, item2 in item + item2.price })
        
        totolPrice = gamePriceTotal + devicePriceTotal
        descriptionLabel.text = "Total: $\(totolPrice.rounded())  |  Cash: $\(cashAmount.rounded())"
    }
    
    
}

// MARK: - extension
extension ItemsController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemToDisplay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
        cell.textLabel?.text = itemToDisplay[indexPath.row].title
        cell.detailTextLabel?.text = String(itemToDisplay[indexPath.row].price)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // if item already in added to wish list
        if wishListArray.contains(where: { $0.title == itemToDisplay[indexPath.row].title }) {
            // do not add item to wish list
            errorPopUp.delegate = self
            view.addSubview(errorPopUp)
            view.shake()
        } else {
            // add item to wish list
            wishListArray.append(itemToDisplay[indexPath.row])
        }
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        wishListArray.remove(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if (itemToDisplay == gamesArray) || (itemToDisplay == deviceArray) {
            return false
        }else{
            return true
        }
    }

}


// MARK: - Popup delegate
extension ItemsController: PopupDelegate {
    
    func handlePopupDismiss() {
        UIView.animate(withDuration: 0.3) {
            self.errorPopUp.removeFromSuperview()
            self.view.shake()
        }
    }
    
}


// MARK: - wallet delegate
extension ItemsController: WalletDelegate {
    
    func handleAmountOfMoney(added: Double) {
        cashAmount += added
        descriptionLabel.text = "Total: $\(totolPrice)  |  Cash: $\(cashAmount.rounded())"
    }
    
}

