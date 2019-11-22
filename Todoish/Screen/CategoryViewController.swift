//
//  ViewController.swift
//  Todoish
//
//  Created by Kateryna Tsysarenko on 24/10/2019.
//  Copyright © 2019 Kateryna Tsysarenko. All rights reserved.
//

import UIKit
import CoreGraphics
import CoreImage
//import DynamicBlurView
import CoreData
import RealmSwift

class CategoryViewController: UIViewController {
    
    let realm = try! Realm()
    
    private var myCategoeries: Results<Category>? = nil
    private let myView = CategoryView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        self.view = myView

        myView.categoryList.delegate = self
        myView.categoryList.dataSource = self

        myView.categoryList.register(CategoryCell.self, forCellReuseIdentifier: CategoryCell.identifier)

        navigationItem.prompt = "Text"
        navigationItem.title = "Categories"
        navigationController?.navigationBar.barTintColor = Color.main
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]

        navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add,
                                                         target: self,
                                                         action: #selector(addButtonPressed)),
                                         animated: true)
        loadData()
    }

    //MARK - NavBar methods

    @objc private func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()

        let alert = UIAlertController(title: "Add New Category",
                                      message: "Let's do this",
                                      preferredStyle: UIAlertController.Style.alert)

        let action = UIAlertAction(title: "Add category",
                                   style: UIAlertAction.Style.default) { (action) in
                                        let newCategory = Category()
                                    newCategory.name = textField.text!
                                        self.save(newCategory)
                                        self.myView.categoryList.reloadData()
        }

        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Input the name of a new item"
            textField = alertTextField
        }

        alert.addAction(action)
        present(alert, animated: true, completion: nil)

    }


    fileprivate func save(_ category: Category) {
        // let encoder = PropertyListEncoder()

        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving context \(error)")
        }
    }

    fileprivate func loadData() {
        
        myCategoeries = realm.objects(Category.self)

        myView.categoryList.reloadData()
    }

}

//MARK - TableView Methods

extension CategoryViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myCategoeries?.count ?? 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.identifier, for: indexPath) as! CategoryCell

        let newColor = Color.darkBlue.withAlphaComponent(CGFloat(indexPath.row+1)/CGFloat(myCategoeries?.count ?? 1))

        cell.setupData(name: myCategoeries?[indexPath.row].name ?? "No categories yet", color: newColor)
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

       let distanationVC = ToDoViewController()
        distanationVC.navigationItem.title = myCategoeries?[indexPath.row].name ?? "No categories yet"
        distanationVC.selectedCategory = myCategoeries?[indexPath.row]
        navigationController?.pushViewController(distanationVC, animated: true)
        
        tableView.cellForRow(at: indexPath)?.isSelected = false
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

}
