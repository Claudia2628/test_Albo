//
//  AirportsManager.swift
//  test_Albo
//
//  Created by Claudia Isamar Delgado Vásquez on 07/06/21.
//

import UIKit

final class AirportsManager {

    static let sharedInstance: AirportsManager = {
        return AirportsManager()
    }()
    
    func getAirports(radius: Int?, longitude: Double?, latitude: Double?, success:@escaping (_ response: AirportsResponse)->Void, failure:@escaping (_ responsError: AirportsResponse, Error)->Void) {
        
        let dataEndpoint: String = "https://aerodatabox.p.rapidapi.com/airports/search/location/\(latitude!)/\(longitude!)/km/\(radius!)/10"
        
        
        guard let confirmURL = URL(string: dataEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        
        //"x-rapidapi-host": "aerodatabox.p.rapidapi.com"
        let headers = [
            "x-rapidapi-key": "4a73e26549mshc96b03dcd9d9ac4p1ec321jsncdee2c78db74"
        ]
        
        var urlRequest = URLRequest(url: confirmURL)
        urlRequest.httpMethod = "GET"
        urlRequest.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            
            if let error = error {
                DispatchQueue.main.async {
                    print("Error took place \(error)")
                }
                 return
             }
            
            guard let responseData = data else {
                DispatchQueue.main.async {
                    print("Error: did not receive data")
                }
                return
            }
            
            let decoder = JSONDecoder()
            var failureR = AirportsResponse()
            
            do {
                let decodedResponse = try decoder.decode(AirportsResponse.self, from: responseData)
                // print(decodedResponse.Value)
                print("success getAirports")
                failureR = decodedResponse
                success(decodedResponse)
                   
            } catch {
                print("Response Failed")
                failure(failureR, error)
                print(error)
            }
            //success()
        }
        task.resume()
        
    }
}


struct AirportsResponse: Decodable {
    var items: [Airports]?

    private enum CodingKeys: String, CodingKey {
        case items
        
    }
}


struct Airports: Codable {
    var icao: String?
    var iata: String?
    var name: String?
    var municipalityName: String?
    var location: AirportLocation?
    var countryCode: String?
}

struct AirportLocation: Codable {
    var lat: Double?
    var lon: Double?
    
}
