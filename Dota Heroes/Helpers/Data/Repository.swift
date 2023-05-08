//
//  Repository.swift
//  Dota Heroes
//
//  Created by Tedjakusuma, Ferdinand on 04/05/23.
//  Copyright © 2023 Tiket.com. All rights reserved.
//

import Foundation

protocol Repository {
    associatedtype Entity

    func get(predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?) -> Result<[Entity], Error>
    func create() -> Result<Entity, Error>
    func delete(entity: Entity) -> Result<Bool, Error>
    func deleteAllRecords() -> Result<Bool, Error>
}

protocol DomainModel {
    associatedtype DomainModelType
    func toDomainModel() -> DomainModelType
}

protocol DomainManageObject {
    associatedtype ManagedObject
    func toManagedObject() -> ManagedObject
}

