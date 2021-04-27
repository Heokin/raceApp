//
//  User.swift
//  raceApp
//
//  Created by Stas Dashkevich on 17.04.21.
//

import Foundation

class User: Codable {
    var userName: String
    var userObstacleImageName: String
    var userCarImageName: String
    var userSpeedCar: Double
    init(userName: String?, userObstacleImageName: String?, userCarImageName: String?, userSpeedCar: Double?) {
        self.userName = userName ?? "Default name"
        self.userObstacleImageName = userObstacleImageName ?? "Default obstacle image"
        self.userCarImageName = userCarImageName ?? "Default car image"
        self.userSpeedCar = userSpeedCar ?? 0
    }
}
