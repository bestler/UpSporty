//
//  Formatter.swift
//  NegroniChallenge
//
//  Created by Nicola Rigoni on 27/10/22.
//

import Foundation

var dateFormatter : DateFormatter {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    return formatter
}

var timeFormatter : DateFormatter {
    let formatter = DateFormatter()
    formatter.timeStyle = .short
    return formatter
}

var dateTimeFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "d, MMM y, HH:mm"
    return formatter
}

func dateFormatted(_ date: Date) -> String {
    if Calendar.current.isDateInToday(date) {
        return todayString
    } else if Calendar.current.isDateInTomorrow(date) {
        return tomorrowString
    } else if Calendar.current.isDateInYesterday(date) {
        return yesterdayString
    } else {
        return dateFormatter.string(from: date)
    }
}


