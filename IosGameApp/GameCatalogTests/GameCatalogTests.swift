//
//  GameCatalogTests.swift
//  GameCatalogTests
//
//  Created by admin on 07/11/22.
//

import XCTest
import Combine
import GameMod
import Core

@testable import GameCatalog
final class GameCatalogTests: XCTestCase {

    let injection = Injection.sharedInstance

    
    func testHomeUseCase() {
        
        var cancellables: Set<AnyCancellable> = []
        
        var data: [GameModel] = []
        let getGameUC: Interactor<
            GetGameRequest,
            [GameModel],
            GetGameRepository<GetGameRemoteDataSource>> = injection.provideGameList()
        
        
        let request = GetGameRequest(pageSize: 10)
        getGameUC.execute(request: request)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    XCTAssertThrowsError(completion)
                case .finished:
                    XCTAssertEqual(data.count, 10, "Failed to get game data")
                }
            }, receiveValue: { result in
                data.append(contentsOf: result)
            }).store(in: &cancellables)
    }
    
    func testGameDetailUseCase() {
        var cancellables: Set<AnyCancellable> = []
        
        var data: GameModel?
        let getGameDetailUC: Interactor<
            GetGameDetailRequest,
            GameModel,
            GetGameDetailRepository<GetGameDetailRemoteDataSource>> = injection.provideGameDetail()
    
        
        let request = GetGameDetailRequest(gameId: 3498)
        getGameDetailUC.execute(request: request)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    XCTAssertThrowsError(completion)
                case .finished:
                    XCTAssertEqual(data?.gameId, 3498, "Failed to get game detail data")
                }
            }, receiveValue: { result in
                data = result
            }).store(in: &cancellables)1
        
        
        let realmGameData = GameRealmEntity()
        realmGameData.gameId = 3498
        realmGameData.gameTitle = "test"
        realmGameData.gameRating = "test"
        realmGameData.gameImage = Data()
        realmGameData.gameReleasedDate = "test"
        realmGameData.gameDesc = "test"
        
        let saveGameUseCase: Interactor<
            GameRealmEntity,
            Bool,
            SaveGameDataRepository<GameLocaleDataSource>> = injection.provideSaveGame()
        
        let requestTwo = GameRealmEntity(value: realmGameData)
        saveGameUseCase.execute(request: requestTwo)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    XCTAssertThrowsError(completion)
                case .finished:
                    break
                }
            }, receiveValue: { result in
                XCTAssertEqual(result, true, "Failed to save game detail data")
            }).store(in: &cancellables)
        
        
        let dataExistUseCase: Interactor<
            String,
            Bool,
            DataExistRepository<GameLocaleDataSource>> = injection.provideExistRepository()
        
        let requestThree = "3498"
        
        dataExistUseCase.execute(request: requestThree)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    XCTAssertThrowsError(completion)
                case .finished:
                    break
                }
            }, receiveValue: { result in
                XCTAssertEqual(result, true, "Failed to get game detail data")
            }).store(in: &cancellables)
        
        
        
        getGameDetailUC.execute(request: request)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    XCTAssertThrowsError(completion)
                case .finished:
                    break
                }
            }, receiveValue: { result in
                XCTAssertEqual(result.gameId, 3498, "Failed to get game detail data")
            }).store(in: &cancellables)
        
        
        let deleteGameUseCase: Interactor<
            String,
            Bool,
            DeleteGameDataRepository<GameLocaleDataSource>> = injection.provideDeleteGame()
        
        deleteGameUseCase.execute(request: requestThree)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    XCTAssertThrowsError(completion)
                case .finished:
                    break
                }
            }, receiveValue: { result in
                XCTAssertEqual(result, true, "Failed to delete game detail data")
            }).store(in: &cancellables)
        
        dataExistUseCase.execute(request: requestThree)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    XCTAssertThrowsError(completion)
                case .finished:
                    break
                }
            }, receiveValue: { result in
                XCTAssertEqual(result, false, "Failed to get game detail data")
            }).store(in: &cancellables)
    }
}
