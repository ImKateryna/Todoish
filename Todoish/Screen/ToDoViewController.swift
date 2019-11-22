//
//  ToDoViewController.swift
//  Todoish
//
//  Created by Kateryna Tsysarenko on 20/11/2019.
//  Copyright © 2019 Kateryna Tsysarenko. All rights reserved.
//

import RealmSwift
import UIKit

class ToDoViewController: UIViewController {
    
    var myList: Results<ToDoItem>?
    let realm = try! Realm()
    
    var selectedCategory: Category? {
        didSet {
            loadData()
        }
    }
    private let myView = ToDoView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view = myView
        
        
        
        // print(FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask))
        
        myView.tableview.delegate = self
        myView.tableview.dataSource = self
        myView.searchBar.delegate = self
        
        myView.tableview.register(MainCell.self, forCellReuseIdentifier: MainCell.identifier)
        
        navigationItem.prompt = "Text"
        navigationController?.navigationBar.barTintColor = Color.main
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add,
                                                         target: self,
                                                         action: #selector(addButtonPressed)),
                                         animated: true)
    }
    
    
    //MARK - NavBar methods
    
    @objc private func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todoish item",
                                      message: "Let's do this",
                                      preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "Add item",
                                   style: UIAlertAction.Style.default) { (action) in
                                    if let currentCategory = self.selectedCategory {
                                        do {
                                            try self.realm.write {
                                                let newItem = ToDoItem()
                                                newItem.title = textField.text!
                                                newItem.dateCreated = Date()
                                                currentCategory.items.append(newItem)
                                                self.realm.add(newItem)
                                            }
                                        } catch {
                                            print("Error to save the item: ", error)
                                        }
                                        
                                        self.myView.tableview.reloadData()
                                    }
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Input the name of a new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    fileprivate func loadData() {
        myList = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        
        myView.tableview.reloadData()
    }
    
}

//MARK - TableView Methods

extension ToDoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("MyList:", myList?.count ?? "NONE")
        return myList?.count ?? 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainCell.identifier, for: indexPath) as! MainCell
        
        let newColor = Color.tanger.withAlphaComponent(CGFloat(indexPath.row+1)/CGFloat(myList?.count ?? 1))
        print("Cell for raw")
        
        if let item = myList?[indexPath.row] {
            cell.setupData(title: item.title, isDone: item.done, color: newColor)
            print("Some item")
        } else {
            cell.setupData(title: "No items added", isDone: false, color: UIColor.clear)
            print("No items")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        
        if let item = myList?[indexPath.row] {
            do {
                try realm.write {
                    
                 item.done = !item.done
                }
            } catch {
                print("Failed to update the item: ", error)
            }
        }
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}

//MARK - SearchBar Methods

extension ToDoViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
                
        myList = myList?.filter(NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)).sorted(byKeyPath: "dateCreated", ascending: false)
        
        myView.tableview.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text?.count == 0 {
            loadData()

            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
    
}

