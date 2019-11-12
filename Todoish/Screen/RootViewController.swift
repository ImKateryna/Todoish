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
import DynamicBlurView

class RootViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var myList = [ToDoItem]()
    
    private let myView = RootView()
    
    let dataFilePath = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory,
        in: FileManager.SearchPathDomainMask.userDomainMask).first?.appendingPathComponent("MyToDo.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view = myView
        
        
        
        print(dataFilePath)
        
        myView.myList.delegate = self
        myView.myList.dataSource = self
        
        myView.myList.register(MainCell.self, forCellReuseIdentifier: MainCell.identifier)
        
        navigationItem.prompt = "Text"
        navigationItem.title = "Todo list"
        navigationController?.navigationBar.barTintColor = Color.main
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add,
                                                         target: self,
                                                         action: #selector(addButtonPressed)),
                                         animated: true)
        
//        if let items = defaults.array(forKey: "ToDoList") as? [ToDoItem] {
//            myList = items
//        }
//
//        for i in 0...2 {
//                let item = ToDoItem()
//                item.setData(withTitle: "Task \(i)")
//                myList.append(item)
//            }
    
        loadData()
        
        
        // navigationItem.rightBarButtonItem?.tintColor = .white
        
        
//        let blurView = DynamicBlurView(frame: UIScreen.main.bounds)
//        blurView.blurRadius = 5
//        myView.addSubview(blurView)
//
//        blurView.trackingMode = .none
//        blurView.animate()
        
    }
    
    //MARK - TableView Methods
    
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
        
        myList[indexPath.row].switchDone()
        
        tableView.cellForRow(at: indexPath)?.accessoryType = myList[indexPath.row].getDone() ? .checkmark : .none
        
        saveData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
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
                                        let newItem = ToDoItem()
                                        newItem.setData(withTitle: newTitle)
                                        self.myList.append(newItem)
                                        self.saveData()
                                        self.myView.myList.reloadData()
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
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(self.myList)
            try data.write(to: self.dataFilePath!)
        } catch {
            print("Error encoding, \(error)")
        }
    }
    
    fileprivate func loadData() {
        if let data = try? Data.init(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                myList = try decoder.decode([ToDoItem].self, from: data)
            } catch {
                print("Error decoding, \(error)")
            }
        }
    }
    
}

