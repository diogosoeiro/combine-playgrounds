import Foundation
import Combine

// Throwing errors from operators examples

struct ERROR_BAD_INPUT_CALCULATION: Error { }
struct DivideByZeroError: Error { }

let denominators = [4, 3, 2, 0].publisher

// TryCatch

denominators
    .tryMap { d -> Double in
        guard d != 0 else { throw ERROR_BAD_INPUT_CALCULATION() }
        return 10.0 / Double(d)
    }
    .tryCatch { error -> Just<Double> in
        print("Got an error: \(error)")
        if error is ERROR_BAD_INPUT_CALCULATION {
            throw DivideByZeroError()
        } else {
            throw error
        }
    }
    .sink(receiveCompletion: { completion in
        print(completion)
    }) { value in
        print(value)
    }

// Try Filter

denominators
    .tryFilter{
        if $0 == 0 {
            throw DivideByZeroError()
        } else {
            return $0 % 2 == 0
        }
    }
    .sink(
        receiveCompletion: { print ("\($0)") },
        receiveValue: { print ("\($0)", terminator: " ") }
     )



