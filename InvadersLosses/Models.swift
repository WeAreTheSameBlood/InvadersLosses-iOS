//
//  Models.swift
//  InvadersLosses
//
//  Created by Andrii Hlybchenko on 27.08.2023.
//

import Foundation

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
    let personnel: Int?
    let personnelStr: String?
    let POW: Int?
    
    enum CodingKeys: String, CodingKey {
        case date, day, personnel
        case personnelStr = "personnel*"
        case POW
    }
}
extension PersonnelLossesModel {
    var props: [(String, String?)] {
        return [
            ("Personnel", personnel?.description ?? "---"),
            ("Personnel*", personnelStr?.capitalized ?? "---"),
            ("POW", POW?.description ?? "---"),
        ]
    }
}
