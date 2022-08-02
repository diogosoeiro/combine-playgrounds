import Foundation
import Combine
import PlaygroundSupport

// Different accumulation operators examples of use

func example(_ title: String, block: () -> Void) {
    print("\n-----------[\(title)]:---------------------")
    block()
    print("----------------------------------------\n\n")
}

// Reduce - Scan prints over time, publishes final result upon completion

example("reduce") {
    let values = [1, 5, 12]
    values.publisher
        .print()
        .reduce(0) { (sum, value) in
            sum + value
        }
        .sink { print($0) }
}

// Count - Publishes number of elements

example("count") {
    let values = [1, 5, 12]
    values.publisher
        .print()
        .count()
        .sink { print($0) }
}

// Last - Publishes last element

example("last") {
    let values = [1, 5, 12]
    values.publisher
        .print()
        .last()
        .sink { print($0) }
}

// First - Publishes first element

example("first") {
    let values = [1, 5, 12]
    values.publisher
        .print()
        .first()
        .sink { print($0) }
}

// Output(at:) - Publishes element at specified index

example("output(at:)") {
    let values = [1, 5, 12, 25, 5, 23]
    values.publisher
        .print()
        .output(at: 2)
        .sink { print($0) }
}

// Max - Publishes max element

example("max") {
    let values = [1, 5, 12, 25, 5, 23]
    values.publisher
        .print()
        .max()
        .sink { print($0) }
}

// Min - Publishes min element

example("min") {
    let values = [1, 5, 12, 25, 5, 23]
    values.publisher
        .print()
        .min()
        .sink { print($0) }
}

// Collect - Publishes a single array

example("collect") {
    let values = [1, 5, 12]
    values.publisher
        .print()
        .collect()
        .sink { print($0) }
}
