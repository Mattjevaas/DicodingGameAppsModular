//
//  GetGameRequest.swift
//  Game
//
//  Created by admin on 26/09/23.
//

public struct GetGameRequest {
    let pageSize: Int
    
    public init(pageSize: Int) {
        self.pageSize = pageSize
    }
}
