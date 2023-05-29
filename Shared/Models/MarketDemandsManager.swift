//
//  MarketDemandsManager.swift
//  EngineYard
//
//  Created by Amarjit on 24/05/2023.
//

import Foundation

/* Handles market demands
 
 In this phase, new Orders for marketable locomotives are determined and
 Existing Orders for old and obsolete locomotives are cancelled.
 
 Consists of four steps, each step dedicated to one locomotive type:
 a. Market for green locomotives
 b. Market for red locomotives
 c. Market for yellow locomotives
 d. Market for blue locomotives
 
Determine how many generations of that locomotive type currently exist. A generation exists if there are dice in either the Orders boxes or the sales boxes or in both.
 
 There are 4 cases of existing generations:
 
 1. No generations:
 Nothing is done for this type.
  
 2. 1 generation:
 If this locomotive type does not have the maximum number of dice, add one die to the Customer Base from
 the dice pool. Then roll all dice in the sales and place them in the empty orders for that locomotive
 type.
 
 3. 2 generations:
 Begin with the older (lower generation number) locomotive.
 Transfer one of the dice from the Customer Base to the dice pool.
 Then roll any remaining dice in the Customer Base and place them in the empty Existing Order boxes for that locomotive. This locomotive is considered old.
 
 The newer generation is now checked. If this loco- motive type does not have the maximum number of dice, add 1 die to the Customer Base from the dice pool. Then the dice in the Customer Base are rolled and placed in the empty Existing Order boxes for that locomotive.
 
 4. 3 generations exist:
 The players begin with the oldest (lowest generation number) locomotive.
 Place all dice from the Custo- mer Base and Existing Orders areas back in the dice pool.
 This locomotive is obsolete – there is no demand for this generation of that locomotive type anymore.
 
 The players continue with the next (middle genera- tion number) locomotive.
 
 If needed, add enough dice from the dice pool to the Customer Base to match the maximum number
 of dice for that locomotive.
 
 Then roll all dice in the Customer Base and place them in the empty Existing Order boxes for
 that locomotive.
 
 Finally, the newest (highest generation number) loco- motive is checked. If this locomotive does not have the maximum number of dice, add 1 die to the Cus- tomer Base from the dice pool. Then all dice in the Customer Base are rolled and are placed in the empty Existing Order boxes for that locomotive type.
 
 */

class MarketDemandsManager {
    private var locomotives: [Locomotive]
    
    init(locomotives: [Locomotive]) {
        self.locomotives = locomotives
    }
    
    /* Determine how many generations of that locomotive type currently exist. A generation exists if there are dice in either the Existing Orders boxes or the Customer Base boxes or in both
     */
    func determineExistingGenerations() {
//        let existingGreen = self.locomotives.map { loco in
//            return ((loco.orders.count > 0 || loco.sales.count > 0) && (loco.colour == .green))
//        }
    }
}
