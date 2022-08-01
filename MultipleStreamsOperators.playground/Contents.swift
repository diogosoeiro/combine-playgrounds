import Foundation
import Combine
import PlaygroundSupport

// Different multiple streams operators examples of use

func example(_ title: String, block: () -> Void) {
    print("\n-----------[\(title)]:---------------------")
    block()
    print("----------------------------------------\n\n")
}

// Merge - Publishes combination of two publishers (same type)

example("Merge") {
    let pub1 = CurrentValueSubject<Int, Never>(100)
    let pub2 = [1, 2, 3].publisher
    
    let merged = pub1.merge(with: pub2)
        .print()
    merged.sink { print($0) }
    
    pub1.send(200)
    pub1.send(completion: .finished)
}

// Merge multiple - Publishes combination of multiple publishers (same type)

example("merge multiple") {
    let pub1 = [1, 2, 3].publisher
    let pub2 = [4, 5, 6].publisher
    let pub3 = [7, 8, 9].publisher
    
    Publishers.MergeMany([pub1, pub2, pub3])
        .sink { print($0) }
}

// Zip - Publishes pairs of elements from two publishers

example("zip") {
    let ints = [1, 2, 3].publisher
    let letters = ["a", "b", "c", "d"].publisher
    
    ints.zip(letters)
        .map { "\($0.0) -> \($0.1)" }
        .sink { print($0) }
}

// Combine latest - Publishes combination of multiple publishers

example("Combine Latest") {
    let pub1 = CurrentValueSubject<Bool, Never>(false)
    let pub2 = CurrentValueSubject<Bool, Never>(false)
    let pub3 = CurrentValueSubject<Bool, Never>(false)
    
    pub1.send(true)
    
    Publishers.CombineLatest3(pub1, pub2, pub3)
        .print("CL")
        .map { switches in
            switches.0 && switches.1 && switches.2
        }
        .filter { $0 }
        .sink { _ in print("OK READY!") }
    
    print("Setting pub2 to true")
    pub2.send(true)

    print("Setting pub3 to true")
    pub3.send(true)
    
}
