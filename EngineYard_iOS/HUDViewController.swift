//
//  HUDViewController.swift
//  EngineYard
//
//  Created by Amarjit on 27/11/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import UIKit

class HUDViewModel : BaseViewModel {
    static let reuseIdentifier = "HUDReusableCellId"
}

class HUDViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var viewModel: HUDViewModel?

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var phaseTextLabel: UILabel!
    @IBOutlet weak var helperTextLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: HUDViewModel.reuseIdentifier)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.backgroundColor = UIColor.clear
        self.collectionView.allowsMultipleSelection = false
        self.collectionView.layoutIfNeeded()
    }

    // MARK: UICollectionView Delegate

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.game?.players?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: HUDViewModel.reuseIdentifier, for: indexPath) //as! UICollectionViewCell

        let playerObj: Player = viewModel?.game?.players?[indexPath.row] as! Player

        let arr = UINib(nibName: "PlayerHUDView", bundle: nil).instantiate(withOwner: nil, options: nil)
        let view = arr[0] as! PlayerHUDView
        cell.contentView.addSubview(view)
        view.configure(with: playerObj)

        view.updateConstraints()
        view.layoutIfNeeded()

        return cell
    }
}

extension HUDViewController {
    public static func loadHUD(game: Game?, viewController: UIViewController) -> HUDViewController? {
        guard let hasGame = game else {
            assertionFailure("** HUD Failure - No game object found **")
            return nil
        }

        let sb: UIStoryboard = UIStoryboard(name: "HUD", bundle: nil)
        let hudVC = sb.instantiateViewController(withIdentifier: "HUDViewController") as? HUDViewController

        if let controller = hudVC
        {
            let view = viewController.view!

            controller.viewModel = HUDViewModel(game: hasGame)
            viewController.addChild(controller)
            controller.view.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(controller.view)

            NSLayoutConstraint.activate([
                controller.view.topAnchor.constraint(equalTo: view.topAnchor),
                controller.view.leftAnchor.constraint(equalTo: view.leftAnchor),
                controller.view.rightAnchor.constraint(equalTo: view.rightAnchor),
                ])

            controller.didMove(toParent: viewController)
        }

        return hudVC
    }
}
