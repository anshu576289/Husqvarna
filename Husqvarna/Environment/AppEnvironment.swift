//
//  AppEnvironment.swift
//  Husqvarna
//
//  Created by Anshu Kumar Ray on 12/03/23.
//

import Foundation

enum AppEnvironment: String {
    case development
    case staging
    case production
}

extension AppEnvironment {
    var serviceBaseUrl: String {
        switch self {
        case .development, .staging, .production:
            return "https://api.themoviedb.org/"
        }
    }
}
