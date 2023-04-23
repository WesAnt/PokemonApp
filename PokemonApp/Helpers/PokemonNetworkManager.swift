//
//  NetworkManager.swift
//  PokemonApp
//
//  Created by Wesley White on 20/04/2023.
//

import Foundation

struct PokemonNetworkManager {
    
    //MARK: - Fetch pokemon list from API
    func pokemonListRequest(with urlString: String, completion: @escaping ([PokemonEntry]) -> ()) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, _, error) in
                if error != nil {
                    print(error!.localizedDescription)
                    return
                }
                guard let data = data else { return }
                do {
                    let pokemonList = try JSONDecoder().decode(PokemonList.self, from: data)
                    
                    DispatchQueue.main.async {
                        completion(pokemonList.results)
                    }
                } catch {
                    print(error.localizedDescription)
                    return
                }
            }
            task.resume()
        }
    }
    
    //MARK: - Fetch pokemon stats from API
    func pokemonStatsRequest(with urlString: String, completion: @escaping (PokemonStats) -> ()) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let dataTask = session.dataTask(with: url) { (data, _, error) in
                if error != nil {
                    print(error!.localizedDescription)
                    return
                }
                guard let data = data else { return }
                
                do {
                    let pokemonStats = try JSONDecoder().decode(PokemonStats.self, from: data)
                    DispatchQueue.main.async {
                        completion(pokemonStats)
                    }
                } catch {
                    print(error.localizedDescription)
                    return
                }
            }
            dataTask.resume()
        }
    }
}
