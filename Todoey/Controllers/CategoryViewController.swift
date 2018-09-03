//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Anne Kristine on 03.09.2018.
//  Copyright © 2018 Thomas Østlyng. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
	
	var categoryArray = [Category]()
	
	let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
	

    override func viewDidLoad() {
        super.viewDidLoad()
		loadCategory()
}
	
//	MARK: - TableView DataSource Methods
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return categoryArray.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryItemCell", for: indexPath)
		
		cell.textLabel?.text = categoryArray[indexPath.row].name
		
		return cell
	}
	
//	MARK: - TableView Delegate Methods
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		performSegue(withIdentifier: "goToItems", sender: self)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		let destinationVC = segue.destination as! ToDoListViewController
		
		if let indexPath = tableView.indexPathForSelectedRow {
			destinationVC.selectedCategory = categoryArray[indexPath.row]
		}
	}
	
//	MARK: - Data Manipulation Mehods
	func saveCategory() {
		do {
			try context.save()
		} catch {
			print("Error saving context \(error)")
		}
		self.tableView.reloadData()
	}
	
	func loadCategory(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
		do {
			categoryArray = try context.fetch(request)
		} catch {
			print("Error fetching data from context \(error)")
		}
		tableView.reloadData()
	}

//	MARK: - Add New Categories
	@IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
		var textField = UITextField()
		let alert = UIAlertController(title: "Add New Category Item", message: "", preferredStyle: .alert)
		let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
			
			let newItem = Category(context: self.context)
			newItem.name = textField.text!
			self.categoryArray.append(newItem)
			
			self.saveCategory()
		}
		
		alert.addTextField { (alertTextField) in
			alertTextField.placeholder = "Create new item"
			textField = alertTextField
		}
		alert.addAction(action)
		present(alert, animated: true, completion: nil)
	}
}
