//
//  OnTime.swift
//  OnTime
//
//  Created by Zahid Shabbir on 22/09/2023.
//

import Foundation
import UIKit
// MARK: - OnTimeElement
struct OnTime: Decodable, Identifiable, OnTimeProtocol {

    let id: String?
    let schedule: Schedule?
    let name: String?
    let image: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case schedule, name
        case image = "visualAidUrl"
    }

    init(id: String? = nil, schedule: Schedule? = nil, name: String? = nil, image: String? = nil) {
            self.id = id
            self.schedule = schedule
            self.name = name
            self.image = image
        }

    init(from onTimeCD: OnTimeCD) {
        self.id = onTimeCD.id
        self.name = onTimeCD.name ?? ""
        self.image = onTimeCD.image
        self.schedule = Schedule(from: onTimeCD.schedule)
    }

    var currentSchedule: String {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "EEE"
           let currentDayOfWeek = dateFormatter.string(from: Date())
        var noSchewdule: String? = "No Schedule"

           switch currentDayOfWeek {
           case "Mon":
               noSchewdule =  schedule?.mon
           case "Tue":
               noSchewdule = schedule?.tue
           case "Wed":
               noSchewdule = schedule?.wed
           case "Thu":
               noSchewdule = schedule?.thu
           case "Fri":
               noSchewdule = schedule?.fri
           case "Sat":
               noSchewdule = schedule?.sat
           case "Sun":
               noSchewdule = schedule?.sun
           default:
               break
           }
        return noSchewdule ?? "No Schedule"
       }

    var currentTime: String { Utility.currentTime }
}

// MARK: - Schedule
struct Schedule: Codable {
    let mon: String?
    let tue: String?
    let wed: String?
    let thu: String?
    let fri: String?
    let sat: String?
    let sun: String?

    enum CodingKeys: String, CodingKey {

        case mon = "Mon"
        case tue = "Tue"
        case wed = "Wed"
        case thu = "Thu"
        case fri = "Fri"
        case sat = "Sat"
        case sun = "Sun"
    }
    init(from scheduleCD: ScheduleCD?) {
        self.mon = scheduleCD?.mon
        self.tue = scheduleCD?.tue
        self.wed = scheduleCD?.wed
        self.thu = scheduleCD?.thu
        self.fri = scheduleCD?.fri
        self.sat = scheduleCD?.sat
        self.sun = scheduleCD?.sun
    }

}

// typealias OnTime = [OnTimeElement]
