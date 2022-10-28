//
//  Int64.swift
//  NegroniChallenge
//
//  Created by Nicola Rigoni on 27/10/22.
//

import Foundation


extension Int64 {
    func asTimeFormatted() -> String {
        let hours = (self / (1000*60*60)) % 24
        let minutes = (self / (1000*60)) % 60
        let seconds = (self / 1000) % 60
        let decimalSeconds = (self % 1000) / 100
        return String(format:"%d:%d:%02d,%02d", hours, minutes, seconds, decimalSeconds)
    }
}

//let formattedTime: String = milliseconds.asTimeFormatted()
