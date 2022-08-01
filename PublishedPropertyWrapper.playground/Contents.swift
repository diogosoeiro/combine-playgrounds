import Foundation
import Combine

// @Published Property Wrapper example

class Car {
    @Published
    private(set) var gasLevel = 1.0
    
    @Published
    private(set) var gasGauge = ""
    
    init() {
        $gasLevel
            .map { String(Int(100 * $0)) + "%" }
            .assign(to: &$gasGauge)
    }
    
    func drive() {
        if gasLevel > 0 {
            print("🚗💨")
            gasLevel -= 0.25
        } else {
            print("⛽️ OUT OF GAS!")
        }
    }
}

let car = Car()

car.$gasGauge
    .sink { print($0) }

car.$gasLevel
    .drop(while: { $0 > 0.4 })
    .sink { _ in print("WARNING LOW ON GAS: \(car.gasGauge)") }
    

car.drive()
car.drive()
car.drive()
car.drive()
car.drive()


