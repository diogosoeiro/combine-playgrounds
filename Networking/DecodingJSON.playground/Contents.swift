import Foundation
import Combine
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

/// # Decoding JSON Models

let session = URLSession.shared
let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1")!

struct Post: Codable {
    let id: Int
    let title: String
    let body: String
    let userId: Int
}

var cancellables = Set<AnyCancellable> = []

session.dataTaskPublisher(for: url)
    .map { $0.data }
    .decode(type: Post.self, decoder: JSONDecoder())
    .sink(
        receiveCompletion: { completion in
            print("Completion: \(completion)")
        },
        receiveValue: { post in
            print("Post: \(post.title)")
        })
    .store(in: &cancellables)
