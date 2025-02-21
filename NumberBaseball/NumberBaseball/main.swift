//
//  NumberBaseball - main.swift
//  Created by Dragon, Aaron.
//  Copyright © yagom academy. All rights reserved.
//

func compareStikeBall(_ randomNumber: Array<Int>, _ userNumber: Array<Int>) -> Bool {
    var strike = 0
    var ball = 0

    userNumber.forEach {
        if randomNumber.contains($0) {
            ball += 1
        }
    }
    strike = zip(randomNumber, userNumber).compactMap {
        $0.0 == $0.1 ? true : nil
    }.count
    ball -= strike

    print("\(strike) 스트라이크, \(ball) 볼")
    return strike == 3 ? true : false
}

func gameStart() {
    let randomNumber = getRandomNumber()

    for round in (0...8).reversed() {
        let userNumber = getUserNumber()

        if compareStikeBall(randomNumber, userNumber) {
            print("사용자 승리")
            return
        }
        print("남은 기회 : \(round)")
    }
    print("컴퓨터 승리...!")
}

func getRandomNumber() -> Array<Int> {
    var randomNumber = Set<Int>()

    while randomNumber.count < 3 {
        randomNumber.insert(Int.random(in: 1...9))
    }
    return Array(randomNumber)
}

func getUserNumber() -> Array<Int> {
    while true {
        print("숫자 3개를 띄어쓰기로 구분해주세요.\n중복숫자는 허용하지 않습니다.")
        print("입력 : ", terminator: "")
        let input = readLine()

        if let userNumber = checkNumber(input) {
            return userNumber
        }
        print("입력이 잘못되었습니다.")
    }
}

func checkNumber(_ userInput: String?) -> Array<Int>? {
    guard let userInput = userInput else { return nil }

    let userInputArr = userInput.split(separator: " ")
    if userInputArr.count != 3 { return nil }

    let userNumber = userInputArr.compactMap{ Int($0) }.filter { $0 > 0 && $0 < 10 }
    if Set(userNumber).count != 3 { return nil }

    return userNumber
}

func selectMenu() {
    enum menu: String {
        case start = "1"
        case stop = "2"
    }

    while true {
        print("1. 게임시작\n2. 게임종료")
        print("원하는 기능을 선택해주세요 : ", terminator: "")

        let menuNumber = readLine()
        if menuNumber == menu.start.rawValue {
            gameStart()
        } else if menuNumber == menu.stop.rawValue {
            return
        } else {
            print("입력이 잘못되었습니다.")
        }
    }
}

selectMenu()
