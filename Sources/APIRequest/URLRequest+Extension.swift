import Foundation
import RxCocoa
import RxSwift

public struct Resource<T> {
  let url: URL
}

extension URLRequest {
  static public func load<T: Decodable>(resource: Resource<T>) -> Observable<T> {
    return Observable.just(resource.url)
      .flatMap { url -> Observable<(response: HTTPURLResponse, data: Data)> in
        let request = URLRequest(url: url)
        return  URLSession.shared.rx.response(request: request)
      }.map{ response,data -> T in
        // if the response status code is within 200 until 300
        if 200..<300 ~= response.statusCode {
          // T.self because codable
          return try JSONDecoder().decode(T.self, from: data)
        } else {
          throw RxCocoaURLError.httpRequestFailed(response: response, data: data)
        }
      }.asObservable()
  }
}

extension URL {
  static public func urlForMeals() -> URL? {
    return URL(string: "https://www.themealdb.com/api/json/v1/1/filter.php?c=Seafood")
  }
  static public func urlForMealsDetail(id: String) -> URL? {
    return URL(string: "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(id)")
  }
  static public func urlForSearch(name: String) -> URL? {
    return URL(string: "www.themealdb.com/api/json/v1/1/search.php?s=\(name)")
  }
}
