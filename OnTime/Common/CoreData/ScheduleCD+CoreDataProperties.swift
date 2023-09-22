//
//  ScheduleCD+CoreDataProperties.swift
//  OnTime
//
//  Created by Zahid Shabbir on 22/09/2023.
//
//

import Foundation
import CoreData

extension ScheduleCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ScheduleCD> {
        return NSFetchRequest<ScheduleCD>(entityName: "ScheduleCD")
    }

    @NSManaged public var mon: String?
    @NSManaged public var tue: String?
    @NSManaged public var wed: String?
    @NSManaged public var thu: String?
    @NSManaged public var fri: String?
    @NSManaged public var sat: String?
    @NSManaged public var sun: String?
    @NSManaged public var onTime: OnTimeCD?

}

extension ScheduleCD: Identifiable {

}
