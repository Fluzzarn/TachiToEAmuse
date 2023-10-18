//
//  eAmusePB.swift
//  tachiToeAmuse
//
//  Created by Dan Mclean on 9/26/23.
//

import Foundation

struct eAmusePB: Codable {
    var title: String
    var difficulty: String
    var level: Int
    var clearRank: String
    var scoreGrade: String
    var hiScore: Int
    var exScore: Int
    var playCount: Int
    var clearAmound: Int
    var ultimateChain: Int
    var perfect: Int
}
