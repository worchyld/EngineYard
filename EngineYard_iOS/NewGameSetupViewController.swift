//
//  NewGameSetupViewController.swift
//  EngineYard
//
//  Created by Amarjit on 05/10/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import UIKit

private struct ViewModel {
    static let pageTitle = "New game setup"
    static let reuseIdentifier = "newGameCellId"
}

@objc protocol ConfigureCellDelegate {
    @objc optional func configure(cell: UITableViewCell, at indexPath:IndexPath)
    @objc optional func configure(cell: UICollectionViewCell, at indexPath: IndexPath)
}

class NewGameSetupViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, ConfigureCellDelegate {

    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = false
        self.title = ViewModel.pageTitle
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }

    // MARK: - CollectionView

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Rules.NumberOfPlayers.max
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ViewModel.reuseIdentifier, for: indexPath)

        configure(cell: cell, at: indexPath)

        return cell
    }

    @nonobjc func configure(cell: UICollectionViewCell, at indexPath: IndexPath) {

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
