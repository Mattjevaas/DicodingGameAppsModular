//
//  GetGameDetailRequest.swift
//  Game
//
//  Created by admin on 26/09/23.
//

public struct GetGameDetailRequest {
    let gameId: Int
    
    public init(gameId: Int) {
        self.gameId = gameId
    }
}
