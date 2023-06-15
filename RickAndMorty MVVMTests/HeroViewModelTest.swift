//
//  HeroViewModelTest.swift
//  RickAndMorty MVVMTests
//
//  Created by Artem on 15.06.2023.
//

import XCTest
@testable import RickAndMorty_MVVM

final class HeroViewModelTest: XCTestCase {
    
    var sut: HeroOnMainTableViewModel!
    var mockApiService: MockNetworkServiceImpl!
    
    override func setUp()  {
        super.setUp()
        mockApiService = MockNetworkServiceImpl()
        sut = HeroOnMainTableViewModel(service: mockApiService)
    }

    override func tearDown()  {
        sut = nil
        mockApiService = nil
        super.tearDown()
    }

    func testFetchDataLoaded() {
        sut.send(event: .onAppear)
        mockApiService.successLoadAllCharacters()
        XCTAssertEqual(sut.state, .loaded)
    }
    
    func testFetchDataFailed() {
        sut.send(event: .onAppear)
        mockApiService.failLoadAllCharacters(error: .notNetworkAvailable)
        XCTAssertEqual(sut.state, .error)
    }
    
    func testEmptyFilteredFetchDataLoaded() {
        sut.send(event: .onFiltered(""))
        XCTAssertEqual(sut.state, .loaded)
    }
    
    func testValidFilteredFetchDataLoaded() {
        sut.send(event: .onFiltered("Foo"))
        mockApiService.successGetFilteredCharacters()
        let modelHero: (NetworkHeroesDataModel?) = NetworkHeroesDataModel(info: Info(count: 1, pages: 1, next: "", prev: ""), results: [CharacterResult(id: 1, name: "", status: "", species: "", type: "", gender: "", origin: Location(name: "", url: ""), location: Location(name: "", url: ""), image: "", episode: [""], url: "", created: "")])
        
        let model = modelHero?.results
        let heroModels = model?.map{HeroModelOnTable(data: $0)}
        XCTAssertEqual(sut.state, .isFiltered(heroModels ?? []))
    }

}
