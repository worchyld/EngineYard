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
        //setupData()
    }

    
    @IBAction func nextBtnPressed(_ sender: Any) {
        coordinator?.showNext()
    }
}

extension ViewController {

    // This is just for testing purposes
    private func setupData() {
        /*
        let listener = NotificationListener()
        NotificationCenter.default.addObserver(listener, selector: #selector(NotificationListener.handleDidSaveNotification(_:)), name: NSNotification.Name.NSManagedObjectContextDidSave, object: nil)

        let delegate = UIApplication.shared.delegate as? AppDelegate

        if let context = delegate?.persistentContainer.viewContext {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DeckEntity")

            do {
                if let items = try context.fetch(fetchRequest) as? [DeckEntity] {
                    print ("\(items.count) results found")

                    if (items.count == 0) {
                        let board = Board()
                        for object in board.decks {
                            let deck = NSEntityDescription.insertNewObject(forEntityName: "DeckEntity", into: context) as! DeckEntity

                            deck.setValue(object.name , forKeyPath: "name")
                            deck.setValue(object.capacity, forKey: "capacity")
                            deck.setValue(object.color.rawValue, forKey: "color")
                            deck.setValue(object.cost, forKey: "cost")
                            deck.setValue(object.generation.rawValue, forKey: "generation")
                            deck.setValue(object.income, forKey: "income")
                            deck.setValue(object.numberOfChildren, forKey: "numberOfChildren")
                            deck.setValue(object.productionCost, forKey: "productionCost")
                            deck.setValue(object.state.rawValue, forKey: "state")

                            //: Make children (cards)

                            //: Save the context so it's populated with the entities.
                            do {
                                try context.save()
                            } catch {
                                print("Error saving context: \(error)")
                            }

                        }
                    }
                    else {
                        print ("Results: ")
                        print ( items[0].value(forKey: "name") as? String ?? "none" )
                        print ( items[0].value(forKey: "capacity") as? Int ?? "none" )
                        print ( items[0].value(forKey: "color")  as? Int ?? "none" )
                        print ( items[0].value(forKey: "cost")  as? Int  ?? "none")
                        print ( items[0].value(forKey: "generation")  as? Int  ?? "none")
                        print ( items[0].value(forKey: "income")  as? Int  ?? "none" )
                        print ( items[0].value(forKey: "numberOfChildren") as? Int  ?? "none")
                        print ( items[0].value(forKey: "productionCost")  as? Int  ?? "none" )
                        print ( items[0].value(forKey: "state") as Any  )
                        print("--------")

                        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

                        do {
                            try context.execute(deleteRequest)
                            try context.save()
                        } catch {
                            print ("There was an error")
                        }

                    }
                }
            } catch {
                print("Failed to fetch data request.")
            }
        }
        */



    }

}
