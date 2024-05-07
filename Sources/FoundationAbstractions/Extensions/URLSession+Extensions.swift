import Foundation

extension URLSession: DataTaskCreating {
    
    public func createDataTask(with request: URLRequest) -> DataTask {
        return dataTask(with: request)
    }
    
}

extension URLSession: NetworkDataFetching {
 
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        try await data(for: request, delegate: nil)
    }

}
