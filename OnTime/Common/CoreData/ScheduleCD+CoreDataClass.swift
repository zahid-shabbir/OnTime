//
//  ScheduleCD+CoreDataClass.swift
//  OnTime
//
//  Created by Zahid Shabbir on 22/09/2023.
//
//

import Foundation
import CoreData

@objc(ScheduleCD)
public class ScheduleCD: NSManagedObject {
    static func prepare(schedule: Schedule?) -> ScheduleCD {
        let newSchedule = ScheduleCD(context: CoreDataManager.shared.context)
        guard let schedule = schedule else {return newSchedule}
        newSchedule.mon = schedule.mon
        newSchedule.tue = schedule.thu
        newSchedule.wed = schedule.wed
        newSchedule.thu = schedule.thu
        newSchedule.fri = schedule.fri
        newSchedule.sat = schedule.sat
        newSchedule.sun = schedule.sun
        return newSchedule
    }
}
