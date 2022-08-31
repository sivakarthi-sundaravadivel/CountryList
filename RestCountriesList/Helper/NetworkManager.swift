//
//  NetworkManager.swift
//  RestCountriesList
//
//  Created by s.sivakarthi on 24/08/2022.
//

import Foundation

class NetworkManager {
    static func fetchData(completion: @escaping ([CountryElement]) -> ()) {
        guard let url = URL(string: "https://restcountries.com/v3.1/all") else {return}
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
        
        URLSession(configuration: config).dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                print(error!)
                return
            }
            
            guard let data = data else {
                fatalError()
                return
            }
            
            do {
                let jsonData = try JSONDecoder().decode([CountryElement].self, from: data)
                completion(jsonData)
            } catch {
                print("Err::", error)
            }

            
            
        }.resume()
    }
}
