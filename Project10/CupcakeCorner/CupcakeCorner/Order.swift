//
//  Order.swift
//  CupcakeCorner
//
//  Created by Maggie Maldjian on 1/22/21.
//

import SwiftUI

class Order: ObservableObject, Codable {

  enum CodingKeys: CodingKey {
    case userOrder
  }

  @Published var userOrder = UserOrder()

  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)

    try container.encode(userOrder, forKey: .userOrder)
  }

  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    userOrder = try container.decode(UserOrder.self, forKey: .userOrder)
  }

  init() { }
}

extension String {
  func noSpaces() -> String {
    return self.trimmingCharacters(in: .whitespaces)
  }
}

struct UserOrder: Codable {
  var types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
  var type = 0
  var quantity = 3

  var specialRequestEnabled = false {
    didSet {
      if !specialRequestEnabled {
        extraFrosting = false
        addSprinkles = false
      }
    }
  }
  var extraFrosting = false
  var addSprinkles = false

  var name = ""
  var streetAddress = ""
  var city = ""
  var zip = ""

  var hasValidAddress: Bool {
    return (name.noSpaces().isEmpty || streetAddress.noSpaces().isEmpty || city.noSpaces().isEmpty || zip.noSpaces().isEmpty) ? false : true
  }

  var cost: Double {
    var cost = Double(quantity) * 2

    //Vanilla is cheapest, Rainbow is most expensive
    cost += (Double(type) / 2)

    if extraFrosting {
      cost += Double(quantity)
    }

    if addSprinkles {
      cost += Double(quantity / 2)
    }

    return cost
  }

  enum CodingKeys: CodingKey {
    case type, types, quantity, extraFrosting, addSprinkles, name, streetAddress, city, zip
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    type = try values.decode(Int.self, forKey: .type)
    types = try values.decode([String].self, forKey: .types)
    quantity = try values.decode(Int.self, forKey: .quantity)
    extraFrosting = try values.decode(Bool.self, forKey: .extraFrosting)
    addSprinkles = try values.decode(Bool.self, forKey: .addSprinkles)
    name = try values.decode(String.self, forKey: .name)
    streetAddress = try values.decode(String.self, forKey: .streetAddress)
    city = try values.decode(String.self, forKey: .city)
    zip = try values.decode(String.self, forKey: .zip)
  }

  init() { }
}
