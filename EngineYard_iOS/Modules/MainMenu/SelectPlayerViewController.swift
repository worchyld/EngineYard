//
//  SelectPlayerViewController.swift
//  EngineYard
//
//  Created by Amarjit on 20/05/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import UIKit

class SelectPlayerViewController: UIViewController, Storyboarded, ReusableView {
    weak var coordinator: MainMenuCoordinator?

    static var reuseIdentifier = "CellID"

    private lazy var tableView: UITableView = {
        let tv = UITableView(frame: self.view.frame, style: .plain)
        tv.delegate = self
        tv.dataSource = self
        tv.allowsSelection = true
        tv.register(UITableViewCell.self, forCellReuseIdentifier: SelectPlayerViewController.reuseIdentifier)
        return tv
    }()

    private let players = PlayerViewModel.create()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Select Avatar"
        self.view.addSubview(self.tableView)
    }
}

// :UITableView delegate extension

extension SelectPlayerViewController: UITableViewDelegate, UITableViewDataSource {

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
       return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.players.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: SelectPlayerViewController.reuseIdentifier, for: indexPath)

       // Configure the cell...
        return configureCell(cell: cell, at: indexPath)
    }

    func configureCell(cell: UITableViewCell, at indexPath: IndexPath) -> UITableViewCell {

        let player = self.players[indexPath.row]
        let image = UIImage(named: player.avatar)
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 15, y: 15, width: 64, height: 64)
        imageView.sizeToFit()

        let label = UILabel(frame: CGRect(x: 80, y: 32, width: 128, height: 32))
        label.text = player.name
        label.font = .systemFont(ofSize: 24)
        label.textAlignment = .left
        label.lineBreakMode = .byTruncatingTail
        label.allowsDefaultTighteningForTruncation = true
        label.numberOfLines = 1

        cell.accessoryType = .disclosureIndicator
        cell.addSubview(imageView)
        cell.addSubview(label)

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print ("didSelect: \(indexPath.row)")

        coordinator?.didFinish()
    }
}
