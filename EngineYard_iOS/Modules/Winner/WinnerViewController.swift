//
//  WinnerViewController.swift
//  EngineYard
//
//  Created by Amarjit on 20/05/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import UIKit

struct WinnerViewModel {
    let players: [PlayerViewModel]

    init() {
        let players = PlayerViewModel.build() // Use generated players for rapid prototyping

        let sortedByHighestCash = {
            return players.sorted(by: {
                (a: PlayerViewModel, b: PlayerViewModel) -> Bool in
                    return (a.cash > b.cash)
            })
        }()

        self.players = sortedByHighestCash
    }
}

// Shows a winner from a collection of dummy players in a tableview

class WinnerViewController: UIViewController, Storyboarded, ReusableView {
    private lazy var cellReuseId = self.theClassName + ".cell"
    private let viewModel = WinnerViewModel()

    private lazy var tableView: UITableView = {
        let tv = UITableView(frame: self.view.frame, style: .plain)
        tv.delegate = self
        tv.dataSource = self
        tv.allowsSelection = false // No selections are further available
        tv.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseId)
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Winner page"
        self.view.addSubview(tableView)
    }
}


// :UITableView delegate extension

extension WinnerViewController: UITableViewDelegate, UITableViewDataSource {

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
       return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.players.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseId, for: indexPath)

       // Configure the cell...
        return configureCell(cell: cell, at: indexPath)
    }

    func configureCell(cell: UITableViewCell, at indexPath: IndexPath) -> UITableViewCell {

        let index = indexPath.row
        let player = self.viewModel.players[index]
        let image = UIImage(named: player.avatar)
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 15, y: 15, width: 64, height: 64)
        imageView.sizeToFit()

        let nameLabel = UILabel(frame: CGRect(x: 80, y: 32, width: 128, height: 32))
        nameLabel.text = player.name
        nameLabel.font = .systemFont(ofSize: 24)
        nameLabel.textAlignment = .left
        nameLabel.lineBreakMode = .byTruncatingTail
        nameLabel.allowsDefaultTighteningForTruncation = true
        nameLabel.numberOfLines = 1

        let cashLabel: UILabel = {
            let label = UILabel(frame: CGRect(x: 180, y: 32, width: 128, height: 32))
            label.text = ("$\(player.cash)")
            label.textAlignment = .left
            label.lineBreakMode = .byTruncatingTail
            label.allowsDefaultTighteningForTruncation = true
            label.numberOfLines = 1
            return label
        }()


        //let tWidth = (ScreenSize.SCREEN_WIDTH - 10)
        let trophyImage = UIImage(named: "trophy")
        let trophyImageView = UIImageView(image: trophyImage)
        trophyImageView.frame = CGRect(x: 280, y: 20, width: 40, height: 40)
        trophyImageView.sizeToFit()
        trophyImageView.layer.opacity = 0.0
        trophyImageView.contentMode = .scaleAspectFit


        if (player.cash >= Constants.endGameCashTrigger) {
            UIView.animate(withDuration: 0.7, delay: 1, options: .curveEaseIn,
                           animations: {
                            let flatColor = UIColor.flat(color: .AquaIsland)
                            cell.backgroundColor = flatColor

            }, completion: { _ in
                UIView.animate(withDuration: 1.0, delay: 0.25, options: .curveEaseIn, animations: {
                    trophyImageView.layer.opacity = 1.0
                })
            })
        }

        cell.addSubview(imageView)
        cell.addSubview(nameLabel)
        cell.addSubview(cashLabel)
        cell.addSubview(trophyImageView)

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}