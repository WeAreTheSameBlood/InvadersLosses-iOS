//
//  Models.swift
//  InvadersLosses
//
//  Created by Andrii Hlybchenko on 27.08.2023.
//

import Foundation

//protocol BasicLossesModelProtocol: ObservableObject, Identifiable, Codable {
//    var id: String { get }
//    var date: String { get }
//    var day: Int { get }
//    var props: [(String, Int?)] { get }
//}

class EquipmentLossesModel: ObservableObject, Identifiable, Codable {
    
    var id: String { date }
    let date: String
    let day: Int
    let aircraft: Int?
    let helicopter: Int?
    let tank: Int?
    let APC: Int?
    let fieldArtillery: Int?
    let MRL: Int?
    let militaryAuto: Int?
    let fuelTank: Int?
    let drone: Int?
    let navalShip: Int?
    let antiAircraftWarfare: Int?
    let specialEquipment: Int?
    let mobileSRBMSystem: Int?
    let greatestLossesDirection: String?
    let vehiclesAndFuelTanks: Int?
    let cruiseMissiles: Int?
    
    
    enum CodingKeys: String, CodingKey {
        
        case date, day, aircraft, helicopter, tank, APC
        case fieldArtillery = "field artillery"
        case MRL
        case militaryAuto = "military auto"
        case fuelTank = "fuel tank"
        case drone
        case navalShip = "naval ship"
        case antiAircraftWarfare = "anti-aircraft warfare"
        case specialEquipment = "special equipment"
        case mobileSRBMSystem = "mobile SRBM system"
        case greatestLossesDirection = "greatest losses direction"
        case vehiclesAndFuelTanks = "vehicles and fuel tanks"
        case cruiseMissiles = "cruise missiles"
    }
}
extension EquipmentLossesModel {
    var props: [(String, Int?)] {
        return [
            ("Aircraft", aircraft),
            ("Helicopter", helicopter),
            ("Tank", tank),
            ("APC", APC),
            ("Field Artillery", fieldArtillery),
            ("MRL", MRL),
            ("Military Auto", militaryAuto),
            ("Fuel Tank", fuelTank),
            ("Drone", drone),
            ("Naval Ship", navalShip),
            ("Anti-Aircraft Warfare", antiAircraftWarfare),
            ("Special Equipment", specialEquipment),
            ("Mobile SRBM System", mobileSRBMSystem),
            ("Vehicles and Fuel Tanks", vehiclesAndFuelTanks),
            ("Cruise Missiles", cruiseMissiles)
        ]
    }
}

class PersonnelLossesModel: ObservableObject, Identifiable, Codable {
    
    var id: String { date }
    let date: String
    let day: Int
    let personnel: String?
    let personnelCount: Int?
    let POW: Int?
    
    enum CodingKeys: String, CodingKey {
        case date, day, personnel
        case personnelCount = "personnel*"
        case POW
    }
    
    var props: [(String, Int?)] {
        return [
            ("Personnel", personnelCount),
            ("Pow", POW),
        ]
    }
    
    var propsPersonnel: [(String, String?)] {
        return [("Personnel*", personnel)]
    }
}
