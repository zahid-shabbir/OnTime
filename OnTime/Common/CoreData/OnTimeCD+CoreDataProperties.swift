//
//  OnTimeCD+CoreDataProperties.swift
//  OnTime
//
//  Created by Zahid Shabbir on 22/09/2023.
//
//

import Foundation
import CoreData

extension OnTimeCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OnTimeCD> {
        return NSFetchRequest<OnTimeCD>(entityName: "OnTimeCD")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var image: String?
    @NSManaged public var schedule: ScheduleCD?

}

extension OnTimeCD: Identifiable {

}
