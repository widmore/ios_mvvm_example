//
//  StoriesTableViewController.swift
//  mvvm test
//
//  Created by Kadir Gönül on 28.08.2018.
//  Copyright © 2018 Kadir Gönül. All rights reserved.
//

import UIKit

class StoriesTableViewController: UITableViewController {
    let viewModel : ListViewModel = ListViewModel()
    let activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView();
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.isLoading.bind { (loading) in
            DispatchQueue.main.async {
                
                let isLoading = loading ?? false
                if isLoading {
                    self.activityIndicator.center = (self.view.center);
                    self.activityIndicator.hidesWhenStopped = true;
                    self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray;
                    self.view.addSubview((self.activityIndicator));
                    self.activityIndicator.startAnimating()
                }else {
                    self.activityIndicator.stopAnimating()
                }
            }
        }
        
        viewModel.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    @IBAction func updateTable(_ sender: Any) {
        viewModel.processFetchedInfo()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section \(section)"
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
        
        let cellVm = viewModel.getCellViewModel(at: indexPath.row)
        
        cell.textLabel?.text = cellVm.name
        
        return cell
    }

}
