//
//  CharacterListWorker.swift
//  BreakingBad
//
//  Created by Anderson Costa on 12/01/2021.
//

import Foundation

final class CharacterListWorker: CharacterListWorkable {

    private let decoder = JSONDecoder()
    private let requester: DataProvider
    private let resourceURL: URL

    init(requester: DataProvider, resourceURL: URL = URL(string: "https://breakingbadapi.com/api/characters")!) {
        self.requester = requester
        self.resourceURL = resourceURL
    }

    func loadCharacters(completion: @escaping (Result<[Character], Error>) -> Void) {
        _ = requester.fetchData(from: resourceURL) { [weak self] result in
            guard let self = self else {
                return
            }

            switch result {
            case let .success(data):
                do {
                    let model = try self.decoder.decode([FailableDecodable<Character>].self, from: data)
                        .compactMap { $0.base }
                    completion(.success(model))
                } catch {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    private struct FailableDecodable<Base: Decodable>: Decodable {
        let base: Base?

        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            base = try? container.decode(Base.self)
        }
    }
}
