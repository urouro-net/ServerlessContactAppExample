//
//  ViewController.swift
//  ContactWithFirebaseExample
//
//  Created by Kenta Nakai on 4/1/18.
//  Copyright © 2018 UROURO. All rights reserved.
//

import Firebase
import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!

    private var category: String?
    private var detail: String?

    private lazy var submitItem: UIBarButtonItem = {
        return UIBarButtonItem(title: "送信",
                               style: .done,
                               target: self,
                               action: #selector(ViewController.submit(_:)))
    }()
    private var db: Firestore {
        return Firestore.firestore()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "お問い合わせ"
        navigationItem.rightBarButtonItem = submitItem

        category = CategoriesViewController.categories[0]
        detail = ""
    }

    @objc func submit(_ sender: Any) {
        view.endEditing(true)
        guard let category = category, let detail = detail else {
            return
        }

        db.collection("contacts").addDocument(data: [
            "category" : category,
            "detail" : detail,
            "date" : Date(),
            "device": device,
            "version": version
        ]) { error in
            if let error = error {
                debugPrint("Error: \(error)")
            } else {
                debugPrint("Success")
            }
        }
    }

}

extension ViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return nil
        } else {
            return "お問い合わせ内容"
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell")!
            cell.accessoryType = .disclosureIndicator
            cell.textLabel?.text = "項目"
            cell.detailTextLabel?.text = category
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell") as! DetailCell
            cell.textView.delegate = self
            return cell
        }
    }

}

extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if indexPath.section == 0 {
            let controller = CategoriesViewController(style: .grouped)
            controller.delegate = self
            controller.selectedCategory = category
            navigationController?.pushViewController(controller, animated: true)
        }
    }

}

extension ViewController: UITextViewDelegate {

    func textViewDidEndEditing(_ textView: UITextView) {
        detail = textView.text
    }

}

extension ViewController: CategoriesViewControllerDelegate {

    func categoriesViewController(_ controller: CategoriesViewController, didSelect category: String) {
        self.category = category
        let indexSet = IndexSet(integer: 0)
        tableView.reloadSections(indexSet, with: .automatic)
        navigationController?.popViewController(animated: true)
    }

}

private extension ViewController {

    var device: String {
        var info = utsname()
        uname(&info)
        let machine = info.machine
        let mirror = Mirror(reflecting: machine)
        var identifier = ""
        for child in mirror.children.enumerated() {
            if let value = child.1.value as? Int8, value != 0 {
                identifier.append(String(UnicodeScalar(UInt8(value))))
            }
        }
        return identifier
    }

    var version: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    }

}
