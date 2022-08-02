import Foundation
import Combine
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

// # Reusable Networking Helpers

let session = URLSession.shared
var cancellables: Set<AnyCancellable> = []
let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1")!

struct TemporaryIssue: Error { }

struct Post: Decodable {
    let id: Int
    let title: String
    let body: String
    let userId: Int
}

var simulatedErrors = 3

func fetchPost() -> AnyPublisher<Post, HTTPError> {
    session.dataTaskPublisher(for: url)
        .assumeHTTP()
        .responseData()
        .decoding(type: Post.self, decoder: JSONDecoder())
        .eraseToAnyPublisher()
}

let publisher = fetchPost()

publisher
    .print("FetchPost")
    .sink(receiveCompletion: { print($0) },
          receiveValue: { print($0) })
    .store(in: &cancellables)


    

