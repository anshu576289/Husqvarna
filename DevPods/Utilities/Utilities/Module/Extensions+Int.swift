//
//  Extensions+Int.swift
//  Husqvarna
//
//  Created by Anshu Kumar Ray on 12/03/23.
//

import Foundation

public extension Int {
    
    func secondsToTime() -> String {
        let (hr,min,sec) = (self / 3600, (self % 3600) / 60, (self % 3600) % 60)
        let h_string = hr < 10 ? "0\(hr)" : "\(hr)"
        let m_string =  min < 10 ? "0\(min)" : "\(min)"
        let s_string =  sec < 10 ? "0\(sec)" : "\(sec)"
        return "\(h_string):\(m_string):\(s_string)"
    }
}

public extension String {
    var localizedString: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func localized(_ args: CVarArg...) -> String {
        return String(format: localizedString, args)
    }
}
