//
//  ViewController.swift
//  myWishList
//
//  Created by MacBook on 5/25/19.
//  Copyright © 2019 Apptive. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    var segmentControl:UISegmentedControl!
    var tableView:UITableView!
    let gamesArray = ["NBA 2k19","Mortal Kombat 11","Fortnite","Mindcraft"]
    let deviceArray = ["MacBook","MackBook Air","MackBook Pro","IMac","IMac Pro","Iphone X","Iphone Xr"]
    
    lazy var itemToDisplay = gamesArray

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        tableView.dataSource = self
        tableView.delegate = self
    }

    // MARK: - Functions
    fileprivate func configureViews(){
        segmentControl = UISegmentedControl(items: ["Games","Devices","WishList"])
        segmentControl.selectedSegmentIndex = 0
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        segmentControl.addTarget(self, action: #selector(segmentIndexSelected), for: .valueChanged)
        
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        let stack = UIStackView(arrangedSubviews: [segmentControl,tableView])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 8
        stack.axis = .vertical
        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            stack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            stack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            stack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ])
    }
    
    
    // MARK: - Methods
    
    
    // MARK: - Selectors
    @objc fileprivate func segmentIndexSelected(){
       
    }
}

// MARK: - extension
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemToDisplay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = itemToDisplay[indexPath.row]
        return cell
    }
    
}
