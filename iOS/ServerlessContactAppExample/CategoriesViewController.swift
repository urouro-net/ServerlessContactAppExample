//
//  CategoriesViewController.swift
//  ContactWithFirebaseExample
//
//  Created by Kenta Nakai on 4/13/18.
//  Copyright © 2018 UROURO. All rights reserved.
//

import UIKit

protocol CategoriesViewControllerDelegate: class {
    func categoriesViewController(_ controller: CategoriesViewController, didSelect category: String)
}

class CategoriesViewController: UITableViewController {

    static let categories: [String] = [
        "ご質問",
        "フィードバック",
        "その他"
    ]

    weak var delegate: CategoriesViewControllerDelegate?
    var selectedCategory: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CategoriesViewController.categories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        let category = CategoriesViewController.categories[indexPath.row]

        cell.textLabel?.text = category

        if let selectedCategory = selectedCategory, selectedCategory == category {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        delegate?.categoriesViewController(self, didSelect: CategoriesViewController.categories[indexPath.row])
    }

}
