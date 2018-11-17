//
//  WinnersListViewController.swift
//  EngineYard
//
//  Created by Amarjit on 17/11/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import UIKit

private struct ViewModel {
    static let reuseIdentifer = "winnerCellId"
}

class WinnersListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private var viewModel: ViewModel = ViewModel()

    lazy var tableView : UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.register(UITableViewCell.self, forCellReuseIdentifier: ViewModel.reuseIdentifier)
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - UITableView

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)

        // Configure the cell...
        //viewModel.configureCell(cell: cell, atIndex: indexPath)

        return cell
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
