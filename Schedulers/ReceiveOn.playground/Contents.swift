import Combine
import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

print("-------- Start ---------")
let c = Just(1)
    .delay(for: .seconds(1), scheduler: DispatchQueue.global())
    .receive(on: DispatchQueue.main)
    .sink { _ in
        print(Thread.current)
    }
print("-------- Done ---------")
