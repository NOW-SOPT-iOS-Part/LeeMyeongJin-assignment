//
//  BoxOfficeModel.swift
//  tvingProject
//
//  Created by 이명진 on 5/8/24.
//

import Foundation

// MARK: - BoxOfficeModel

struct MovieModel: Codable {
    let boxOfficeResult: BoxOfficeResult
}

// MARK: - BoxOfficeResult

struct BoxOfficeResult: Codable {
    let boxofficeType, showRange: String
    let dailyBoxOfficeList: [DailyBoxOfficeList]
}

// MARK: - DailyBoxOfficeList

struct DailyBoxOfficeList: Codable {
    let rnum, rank, rankInten, rankOldAndNew: String
    let movieCd, movieNm, openDt, salesAmt: String
    let salesShare, salesInten, salesChange, salesAcc: String
    let audiCnt, audiInten, audiChange, audiAcc: String
    let scrnCnt, showCnt: String?
}
