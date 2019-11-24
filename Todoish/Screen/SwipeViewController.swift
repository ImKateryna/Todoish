//
//  SwipeViewController.swift
//  Todoish
//
//  Created by Kateryna Tsysarenko on 24/11/2019.
//  Copyright © 2019 Kateryna Tsysarenko. All rights reserved.
//

import UIKit
import SwipeCellKit

class SwipeViewController: UIViewController, SwipeTableViewCellDelegate {
    

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }

        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            self.deleteObject(at: indexPath)
        }

        deleteAction.image = UIImage(named: "delete-icon")
        
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        return options
    }
    
    func deleteObject(at indexPath: IndexPath) {
        
    }

}
