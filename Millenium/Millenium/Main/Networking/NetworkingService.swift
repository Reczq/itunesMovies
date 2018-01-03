import Foundation

final class NetworkingService {

    func fetchData(onCompletion: @escaping ([ResultsModel]) -> ()) {
        let url = URL(string: "https://rss.itunes.apple.com/api/v1/us/movies/top-movies/all/3/explicit.json")!
        let seesion = URLSession.shared

        let task = seesion.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }

            do {
                let movies = try JSONDecoder().decode(MovieModel.self, from: data)
                guard let results = movies.feed?.results else { return }
                DispatchQueue.main.async {
                    onCompletion(results)
                }
            } catch {
                print("ERROR")
            }
        }
        task.resume()
    }
}
