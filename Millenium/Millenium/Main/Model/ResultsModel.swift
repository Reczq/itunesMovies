struct ResultsModel: Decodable {
    var artistName: String?
    var releaseDate: String?
    var name: String?
    var kind: String?
    var artworkUrl100: String?
    var genre: [GenreModel]?
}
