//
//  NetworkManager.swift
//  CastleRock
//
//  Created by Venkata Pranathi Immaneni on 1/22/22.
//

import Foundation

/*
***************************************************
*****************  API NetworkManager  ************
***************************************************
*/

class NetworkManager: NSObject {
    
    /*
     ***********  Internal Properties  ***********
    */
    static internal let sharedInstance = NetworkManager()
    
    /*
     ***********  Internal Methods  ***********
    */
    
    /*
     This function is used to retrieve the data from network and decode the data to the Signs Array
     -Parameter url: This is of type URL, from which data is retrieved.
     -Paramater completion: If the data is retrieved successfully, a callback is sent to the ViewModel with the [Sign] array, else callback is sent with an error
     
     */
    internal func getDataFromNetwork(url: URL, completion: @escaping ([Signs]?, Error?) -> Void) {

        let urlRequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if error != nil {
                completion(nil, error)
            }
            if let data = data {
                let jsonDecoder = JSONDecoder()
                do {
                    let signs = try jsonDecoder.decode([Signs].self, from: data)
                    completion(signs, nil)
                } catch {
                    completion(nil, error)
                }
            } else {
                completion(nil, error)
            }
            
        }.resume()
        
    }
    
}
