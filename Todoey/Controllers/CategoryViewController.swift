//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Anne Kristine on 03.09.2018.
//  Copyright © 2018 Thomas Østlyng. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
	
	let realm = try! Realm()
	
	var categories: Results<Category>?

    override func viewDidLoad() {
        super.viewDidLoad()
		loadCategory()
}
	
//	MARK: - TableView DataSource Methods
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return categories?.count ?? 1
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryItemCell", for: indexPath)
		
		cell.textLabel?.text = categories?[indexPath.row].name ?? "No categories added yet"
		
		return cell
	}
	
//	MARK: - TableView Delegate Methods
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		performSegue(withIdentifier: "goToItems", sender: self)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		let destinationVC = segue.destination as! ToDoListViewController
		
		if let indexPath = tableView.indexPathForSelectedRow {
			destinationVC.selectedCategory = categories?[indexPath.row]
		}
	}
	
//	MARK: - Data Manipulation Mehods
	func save(category: Category) {
		do {
			try realm.write {
				realm.add(category)
			}
		} catch {
			print("Error saving context \(error)")
		}
		self.tableView.reloadData()
	}
	
	func loadCategory() {
		
		categories = realm.objects(Category.self)

		tableView.reloadData()
	}

//	MARK: - Add New Categories
	@IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
		var textField = UITextField()
		let alert = UIAlertController(title: "Add New Category Item", message: "", preferredStyle: .alert)
		let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
			
			let newCategory = Category()
			newCategory.name = textField.text!
			
			self.save(category: newCategory)
		}
		
		alert.addTextField { (alertTextField) in
			alertTextField.placeholder = "Create new item"
			textField = alertTextField
		}
		alert.addAction(action)
		present(alert, animated: true, completion: nil)
	}
}
