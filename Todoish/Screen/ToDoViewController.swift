//
//  ToDoViewController.swift
//  Todoish
//
//  Created by Kateryna Tsysarenko on 20/11/2019.
//  Copyright © 2019 Kateryna Tsysarenko. All rights reserved.
//

import CoreData
import UIKit

class ToDoViewController: UIViewController {
    
    var myList = [ToDoItem]()
    
    var selectedCategory: Category? {
        didSet {
            loadData()
        }
    }
    private let myView = ToDoView()
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view = myView
        
        
        
        print(FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask))
        
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
                                    if let newTitle = textField.text {
                                        
                                        let newItem = ToDoItem(context: self.context)
                                        newItem.title = newTitle
                                        newItem.parentCategory = self.selectedCategory
                                        self.myList.append(newItem)
                                        self.saveData()
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
    
    private func createOverlay(frame: CGRect,
                               xOffsetFrom: CGFloat,
                               yOffsetFrom: CGFloat,
                               radius: CGFloat) -> CALayer {
        
        let shape = CAShapeLayer()
        //        shape.fillColor = UIColor.black.withAlphaComponent(0.5).cgColor
        //        shape.strokeColor = UIColor.red.cgColor
        
        let path = CGMutablePath()
        path.addArc(center: CGPoint(x: xOffsetFrom, y: yOffsetFrom),
                    radius: radius,
                    startAngle: 0.0,
                    endAngle: 2.0 * .pi,
                    clockwise: false)
        path.addRect(frame)
        
        let newPath = CGMutablePath()
        newPath.addArc(center: CGPoint(x: 200, y: 150),
                       radius: radius,
                       startAngle: 0.0,
                       endAngle: 2.0 * .pi,
                       clockwise: false)
        newPath.addRect(frame)
        
        shape.path = path
        shape.fillRule = .evenOdd
        
        
        let animation = CABasicAnimation(keyPath: "path")
        animation.toValue = newPath
        
        animation.duration = 2
        shape.add(animation, forKey: "Animation")
        
        return shape
    }
    
    fileprivate func saveData() {
        // let encoder = PropertyListEncoder()
        
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
    }
    
    fileprivate func loadData(with request: NSFetchRequest<ToDoItem> = ToDoItem.fetchRequest(), predicate: NSPredicate? = nil) {
        let categoryPredicate = NSPredicate(format: "parentCategory.name == %@", selectedCategory!.name!)
        
        if let additionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
        } else {
            request.predicate = categoryPredicate
        }
        
        do {
            let data = try context.fetch(request)
            myList = data
        } catch {
            print("Error fetching data: \(error)")
        }
        
        myView.tableview.reloadData()
    }
    
}

//MARK - TableView Methods

extension ToDoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        myList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainCell.identifier, for: indexPath) as! MainCell
        
        let newColor = Color.tanger.withAlphaComponent(CGFloat(indexPath.row+1)/CGFloat(myList.count))
        
        cell.setupData(item: myList[indexPath.row], color: newColor)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        
        myList[indexPath.row].done = !myList[indexPath.row].done
        tableView.cellForRow(at: indexPath)?.accessoryType = myList[indexPath.row].done ? .checkmark : .none
        
        //     context.delete(myList[indexPath.row])
        //     myList.remove(at: indexPath.row)
        
        saveData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        //  tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}

//MARK - SearchBar Methods

extension ToDoViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let request : NSFetchRequest<ToDoItem> = ToDoItem.fetchRequest()
        
        if let text = searchBar.text {
            
            request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
            
            loadData(with: request, predicate: NSPredicate(format: "title CONTAINS[cd] %@", text))
        }
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

