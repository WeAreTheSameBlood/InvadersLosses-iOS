//
//  UrlLoadService.swift
//  InvadersLosses
//
//  Created by Andrii Hlybchenko on 27.08.2023.
//

import Foundation
import SwiftUI

class UrlLoadService {
    private init() {}
    public static let shared = UrlLoadService()
    
    public func fetchEquipJsonFromUrl(urlAddress: String, completion: @escaping ([EquipmentLossesModel]?) -> Void) {
        guard let url = URL(string: urlAddress) else {
            print("Invalid URL")
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data:", error)
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data returned")
                completion(nil)
                return
            }

            do {
                let records = try JSONDecoder().decode([EquipmentLossesModel].self, from: data)
                completion(records)
            } catch {
                print("Decoding error:", error)
                completion(nil)
            }
            
        }.resume()
    }
    public func fetchPersonsJsonFromUrl(urlAddress: String, completion: @escaping ([PersonnelLossesModel]?) -> Void) {
        guard let url = URL(string: urlAddress) else {
            print("Invalid URL")
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data:", error)
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data returned")
                completion(nil)
                return
            }

            do {
                let records = try JSONDecoder().decode([PersonnelLossesModel].self, from: data)
                completion(records)
            } catch {
                print("Decoding error:", error)
                completion(nil)
            }
            
        }.resume()
    }
}
