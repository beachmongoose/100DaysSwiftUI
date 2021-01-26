//
//  FilteredList.swift
//  CoreDataProjectChallenge
//
//  Created by Maggie Maldjian on 1/26/21.
//

import SwiftUI

struct FilteredList: View {
  var fetchRequest: FetchRequest<Singer>
  var singers: FetchedResults<Singer> { fetchRequest.wrappedValue }
    var body: some View {
      List(singers, id: \.self) { singer in
        Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
      }
    }

  init(filter: String, sortType: Name, ascending: Bool, predicateName: Name, predicate: PredicateType) {
    var firstPart: String {
      switch predicateName {
      case .first:
        return "firstName "
      case .last:
        return "lastName "
      case .full:
        return ""
      }
    }
    var secondPart: String {
      switch predicate {
      case .beginsWith:
        return "BEGINSWITH"
      case .endsWith:
        return "ENDSWITH"
      case .contains:
        return "CONTAINS"
      }
    }
    var predicateString: NSCompoundPredicate {
      if predicateName == .full {
        let one = NSPredicate(format: "firstName \(secondPart)[c] %@", filter)
        let two = NSPredicate(format: "lastName \(secondPart)[c] %@", filter)
        return NSCompoundPredicate(type: .or, subpredicates: [one, two])
      } else {
        let one = NSPredicate(format: "\(firstPart)\(secondPart)[c] %@", filter)
        return NSCompoundPredicate(type: .or, subpredicates: [one])
      }
    }

    let sortDescriptor = [NSSortDescriptor(keyPath: (sortType == Name.first) ? \Singer.firstName : \Singer.lastName, ascending: ascending)]
    if filter == "" {
      fetchRequest = FetchRequest<Singer>(entity: Singer.entity(), sortDescriptors: sortDescriptor)
    } else {
      print(predicateString)
      print(filter)
      fetchRequest = FetchRequest<Singer>(entity: Singer.entity(), sortDescriptors: sortDescriptor, predicate: predicateString)
    }
  }
}
