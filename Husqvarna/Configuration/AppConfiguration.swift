//
//  AppConfiguration.swift
//  Husqvarna
//
//  Created by Anshu Kumar Ray on 12/03/23.
//

final class AppConfiguration {
    static let shared = AppConfiguration()
    private init() { }
    static var appConfig: Configuration?
}
