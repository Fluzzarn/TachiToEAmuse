//
//  main.swift
//  tachiToeAmuse
//
//  Created by Dan Mclean on 9/26/23.
//

import Foundation
import TabularData

print("Loading File")
let filePath = CommandLine.arguments[1]
let url = URL(fileURLWithPath: filePath)
do {
    let jsonData = try Data(contentsOf: url)
    let decoder = JSONDecoder()
    let decodedStruct = try decoder.decode([PersonalBest].self, from: jsonData)
    var filtered = decodedStruct.filter { pb in
        pb.scoreData?.scoreDataOptional?.exScore != nil
    }
    for pb in filtered {
        print("\(pb.related?.song?.title! ?? ""): \(pb.scoreData?.scoreDataOptional?.exScore! ?? 0)")
    }
    var eamusePbs:[eAmusePB] = []
    for pb in decodedStruct {
        let exScore = pb.scoreData?.scoreDataOptional?.exScore ?? 0
        let score = pb.scoreData?.score
        let title = pb.related?.song?.title
        let lamp = pb.scoreData?.lamp?.replacingOccurrences(of: "CLEAR", with: "COMPLETE", options: .caseInsensitive, range:nil) ?? "PLAYED"
        let scoreGrade = pb.scoreData?.grade ?? "F"
        let levelNum = pb.related?.chart?.levelNum ?? 0
        let difficulty = difficultyConversion(diff: pb.related?.chart?.difficulty?.uppercased() ?? "")
        let ultimateChain = pb.scoreData?.lamp?.contains("ULTIMATE") ?? false ? 1 : 0
        let puc = pb.scoreData?.lamp?.contains("PERFECT") ?? false ? 1 : 0
        
        let newItem = eAmusePB(title: title ?? "", difficulty: difficulty, level: levelNum, clearRank: lamp, scoreGrade: scoreGrade, hiScore: score ?? 0, exScore: exScore , playCount: 1, clearAmound: 1, ultimateChain: ultimateChain, perfect: puc)
        eamusePbs.append(newItem)
        
    }
    
    var dataFrame = DataFrame()
    dataFrame.append(column: Column(name: "楽曲名", contents: eamusePbs.map({$0.title})))
    dataFrame.append(column: Column(name: "難易度", contents: eamusePbs.map({$0.difficulty
    })))
    dataFrame.append(column: Column(name: "楽曲レベル", contents: eamusePbs.map({$0.level
    })))
    dataFrame.append(column: Column(name: "クリアランク", contents: eamusePbs.map({$0.clearRank
    })))
    dataFrame.append(column: Column(name: "スコアグレード", contents: eamusePbs.map({$0.scoreGrade
    })))
    dataFrame.append(column: Column(name: "ハイスコア", contents: eamusePbs.map({$0.hiScore
    })))
    dataFrame.append(column: Column(name: "EXスコア", contents: eamusePbs.map({$0.exScore
    })))
    dataFrame.append(column: Column(name: "プレー回数", contents: eamusePbs.map({$0.playCount
    })))
    dataFrame.append(column: Column(name: "クリア回数", contents: eamusePbs.map({$0.clearAmound
    })))
    dataFrame.append(column: Column(name: "ULTIMATE CHAIN", contents: eamusePbs.map({$0.ultimateChain
    })))
    dataFrame.append(column: Column(name: "PERFECT", contents: eamusePbs.map({$0.perfect
    })))
    print("\(dataFrame)")
    
    try dataFrame.writeCSV(to: FileManager.default.homeDirectoryForCurrentUser.appending(component: "scores.csv")   )
} catch {print(error)}



func difficultyConversion(diff: String) -> String {
    switch diff {
    case "EXH":
        return "EXHAUST"
    case "MXM":
        return "MAXIMUM"
    case "ADV":
        return "ADVANCED"
    case "NOV":
        return "NOVICE"
    case "GRV":
        return "GRAVITY"
    case "HVN":
        return "HEAVENLY"
    case "VVD":
        return "VIVID"
    case "XCD":
        return "EXCEED"
    case "INF":
        return "INFINITE"
    default:
        fatalError()
    }
}
