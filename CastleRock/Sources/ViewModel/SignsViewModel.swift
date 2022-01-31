//
//  SignsViewModel.swift
//  CastleRock
//
//  Created by Venkata Pranathi Immaneni on 1/22/22.
//

import UIKit

/*
***************************************************
*****************  SignsViewModel  ***************
***************************************************
*/

class SignsViewModel: NSObject {
    
    /*
     ***********  Private Properties  ***********
    */
    private var networkManager: NetworkManager!

    /*
     ***********  Internal Properties  ***********
    */
    internal static let sharedInstance = SignsViewModel()
    internal var signs: [Signs]?
    
    /*
     ***********  Private Methods  ***********
    */
    
    /*
     This function is used to sort the Last Updated with latest updated displayed first
     */
    private func sortByLastUpdated(signs: [Signs]) {
        self.signs = signs.sorted(by: { a, b in
            a.lastUpdated > b.lastUpdated
        })
    }
    
    /*
     ***********  Internal Methods  ***********
    */
    
    /*
     This function is used to retrieve the data that is received from the network by the Network Manager and send updates to the View accordingly.
     -Paramater completion: A callback is sent with an error, if there us ab error received from the network manager
     
     */
    internal func fetchSignsDataFromNetwork(completion: @escaping (Error?)->()) {
        NetworkManager.sharedInstance.getDataFromNetwork(url: URL(string: "https://idtg.carsprogram.org/signs_v1/api/signs")!) { array, error in
            if let signsArray = array {
                self.sortByLastUpdated(signs: signsArray)
                completion(nil)
            } else {
                completion(error)
            }
        }
    }
    
    /*
     Helper function to retrieve the display names
     */
    internal func getSignDisplayNameAtIndex(index: Int) -> String {
        return self.signs?[index].name ?? ""
    }
    
    /*
     Helper function to retrieve the sign status
     */
    internal func getSignStatusAtIndex(index: Int) -> String {
        return self.signs?[index].status ?? ""
    }
    
    /*
     Helper function to retrieve the display object
     */
    internal func getSignDisplayAtIndex(index: Int) -> Display {
        return self.signs![index].display
    }
}
