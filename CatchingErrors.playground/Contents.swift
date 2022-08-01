import Foundation
import Combine

// Catching errors examples

struct DummyError: Error { }

// Send values and error

let subject = PassthroughSubject<Int, DummyError>()

subject.sink(
    receiveCompletion: { completion in
        print("Completion: \(completion)")
    },
    receiveValue: { value in
        print("Value: \(value)")
    })

subject.send(1)
subject.send(completion: .failure(DummyError()))
subject.send(2)

// Catching errors

let subject2 = PassthroughSubject<Int, DummyError>()
subject2
    .catch { error -> Just<Int> in
        print("Error: \(error)")
        return Just(-1)
    }
    .sink(
        receiveCompletion: { completion in
            print("Completion: \(completion)")
        },
        receiveValue: { value in
            print("Value: \(value)")
        })
subject2.send(1)
subject2.send(completion: .failure(DummyError()))
subject2.send(2)

// Replacing error with a value

let pub3 = [4, 2, 5, 1, 5, 2, 1].publisher
let pub4 = pub3
    .tryMap { value throws -> Int in
        if value < 2 {
            throw DummyError()
        } else {
            return value
        }
    }

pub4
    .replaceError(with: -1)
    .sink(
        receiveCompletion: { completion in
            print("Completion: \(completion)")
        },
        receiveValue: { value in
            print("Value: \(value)")
        })

    
    
