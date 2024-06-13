//
//  ViewController.swift
//  GroceryList
//
//  Created by Armando Isais Olguin Cabrera  on 10/06/24.
//

import UIKit

class ViewController: UIViewController {
    
    private var viewModel = GroceryListViewModel()
    private let tableView = UITableView()
    private let itemTextField = UITextField()
    private let addButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    func setupUI(){
        view.backgroundColor = .systemBackground
        itemTextField.placeholder = "eg eggs"
        itemTextField.borderStyle = .roundedRect
        itemTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(itemTextField)
        
        addButton.setTitle("Submit", for: .normal)
        addButton.addTarget(self, action: #selector(addItem), for: .touchUpInside)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.backgroundColor = .systemBlue
        view.addSubview(addButton)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            itemTextField.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor ,constant: 16),
            itemTextField.leadingAnchor.constraint(equalTo:view.leadingAnchor ,constant: 16),
            itemTextField.trailingAnchor.constraint(equalTo:view.trailingAnchor ,constant: -16),
            
            addButton.topAnchor.constraint(equalTo: itemTextField.bottomAnchor, constant: 16),
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            tableView.topAnchor.constraint(equalTo:addButton.bottomAnchor ,constant: 16),
            tableView.leadingAnchor.constraint(equalTo:view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo:view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    
    @objc private func addItem(){
        guard let itemName = itemTextField.text, !itemName.isEmpty else {return}
        viewModel.addItem(name: itemName)
        tableView.reloadData()
        itemTextField.text = ""
    }

}


extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item = viewModel.items[indexPath.row]
        cell.textLabel?.text = item.name
        return cell
    }
    
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
     
        if editingStyle == .delete {
            viewModel.removeItem(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
    }
    
}
