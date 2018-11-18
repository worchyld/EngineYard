//
//  WinnersListViewController.swift
//  EngineYard
//
//  Created by Amarjit on 18/11/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import UIKit

private let reuseIdentifier = "WinnersCellId"

class WinnersListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    lazy var tableView : UITableView = {
        let tv = UITableView(frame: self.view.frame, style: .plain)
        tv.delegate = self
        tv.dataSource = self
        tv.allowsSelection = false
        tv.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Winners"
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)

        // Configure the cell...

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
