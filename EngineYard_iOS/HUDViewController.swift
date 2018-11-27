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
    }

    // MARK: UICollectionView Delegate

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: HUDViewModel.reuseIdentifier, for: indexPath) //as! UICollectionViewCell


        return cell
    }
}
