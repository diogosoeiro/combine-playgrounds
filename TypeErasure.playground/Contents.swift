import Foundation
import Combine

// Type Erasure example

func myNumberPublisher() -> AnyPublisher<Int, Never> {
    let publisher = [1, 2, 3].publisher
        .merge(with: [4, 5, 6].publisher)
        .dropFirst()
        .prepend([1, 2, 3])

    return publisher.eraseToAnyPublisher()
}

let pub = myNumberPublisher()
print(pub)
pub.sink{ print($0) }
