//
//  ViewController.swift
//  EngineYard
//
//  Created by Amarjit on 20/09/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, Storyboarded {
    weak var coordinator: MainCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    @IBAction func nextBtnPressed(_ sender: Any) {
        coordinator?.showNext()
    }
}

extension ViewController {

    func setupData() {

        let delegate = UIApplication.shared.delegate as? AppDelegate

        if let context = delegate?.persistentContainer.viewContext {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DeckEntity")

            do {
                if let items = try context.fetch(fetchRequest) as? [DeckEntity] {
                    print (items)
                }
            } catch {
                print("Failed to fetch data request.")
            }
        }


    }

}
