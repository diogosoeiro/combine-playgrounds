import Foundation
import Combine
import PlaygroundSupport

// FlatMap and SwitchToLatest examples

PlaygroundPage.current.needsIndefiniteExecution = true

let urls = [
    "https://combineswift.com",
    "https://apple.com",
    "https://twitter.com"
].map { URL(string: $0)! }

var cancellables: Set<AnyCancellable> = []

func exampleFlatMap() {
    urls.publisher
        .print("URLS")
        .flatMap(maxPublishers: .max(2)) {
            URLSession.shared.dataTaskPublisher(for: $0)
                .assertNoFailure()
        }
        .print("FLATMAP")
        .sink { (data, response) in
            print("Received \(data.count) bytes from \(response.url!)")
        }
        .store(in: &cancellables)
}

exampleFlatMap()

func exampleSwitchToLatest() {
    urls.publisher
        .print("URLS")
        .map {
            URLSession.shared.dataTaskPublisher(for: $0)
                .assertNoFailure()
                .print("FETCH:\($0)")
        }
        .switchToLatest()
        .print("SWITCH TO LATEST")
        .sink { (data, response) in
            print("Received \(data.count) bytes from \(response.url!)")
        }
        .store(in: &cancellables)
}

func exampleSimpleSwitchToLatest() {
    let x = [[1], [2], [3]]
    
    x.publisher
        .map { $0.publisher }
        .switchToLatest()
        .sink { int in
            print(int)
        }
}

exampleSwitchToLatest()
exampleSimpleSwitchToLatest()
