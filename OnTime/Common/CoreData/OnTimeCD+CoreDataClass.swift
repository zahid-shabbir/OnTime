//
//  OnTimeCD+CoreDataClass.swift
//  OnTime
//
//  Created by Zahid Shabbir on 22/09/2023.
//
//

import Foundation
import CoreData
import Combine

@objc(OnTimeCD)
public class OnTimeCD: NSManagedObject {
    static func saveOnTime(onTime: [OnTime]) {
        self.deleteOnTimes()
        for onTime in onTime {
            let newonTime = OnTimeCD(context: CoreDataManager.shared.context)
            newonTime.id = onTime.id
            newonTime.name = onTime.name
            newonTime.image = onTime.image

            newonTime.schedule = ScheduleCD.prepare(schedule: onTime.schedule)
        }
        CoreDataManager.shared.saveContext()
    }

    static func getOnTimes() -> AnyPublisher<[OnTime], NetworkError> {
        let fetchRequest: NSFetchRequest<OnTimeCD> = OnTimeCD.fetchRequest()

        do {
            let onTime = try CoreDataManager.shared.context.fetch(fetchRequest)
            let rems = onTime.map { OnTime(from: $0) }
            return createPublisher(from: rems)
        } catch {
            return createPublisher(from: [])
        }
    }

    private static func createPublisher(from onTime: [OnTime]) -> AnyPublisher<[OnTime], NetworkError> {
        return Just(onTime)
            .setFailureType(to: NetworkError.self)
            .eraseToAnyPublisher()
    }

    static func deleteOnTimes() {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = OnTimeCD.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print("Failed to delete onTime: \(error)")
        }
    }

}
