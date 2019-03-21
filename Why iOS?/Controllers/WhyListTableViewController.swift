//
//  WhyListTableViewController.swift
//  Why iOS?
//
//  Created by shelby gold on 3/20/19.
//  Copyright © 2019 shelby gold. All rights reserved.
//

import UIKit

class WhyListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        WhyController.getWhy { (success) in
            if success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                
            }
        }
        
    }

    // MARK: - Table view data source

  

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return WhyController.shared.why.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "whyCell", for: indexPath) as? WhyCustomTableViewCell

        let whyList = WhyController.shared.why[indexPath.row]
        cell?.why = whyList

        return cell ?? UITableViewCell()
    }
    
    
    @IBAction func addWhyButtonTapped(_ sender: Any) {
        let alertcontroller = UIAlertController(title: "why is ios cool to you?", message: nil, preferredStyle: .alert)
        alertcontroller.addTextField { (textField) in
            textField.placeholder = "enter name"
        }
        alertcontroller.addTextField { (textField) in
            textField.placeholder = "enter cohort"
        }
        alertcontroller.addTextField { (textField) in
            textField.placeholder = "enter your reason why iOS is Awesome!"
        }
        let addAction = UIAlertAction(title: "add", style: .default) { (_) in
            guard let name = alertcontroller.textFields?[0].text,
            let cohort = alertcontroller.textFields?[1].text,
                let reason = alertcontroller.textFields?[2].text else {return}
            WhyController.postWhy(name: name, cohort: cohort, reason: reason, completion: { (success) in
                if success {
                    print("you did it")
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            })
        }
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        
        alertcontroller.addAction(addAction)
        alertcontroller.addAction(cancelAction)
        
        present(alertcontroller, animated: true, completion: nil)
    }
}
