//
//  InOut.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2022/05/12.
//

import Foundation

/*
 通常、引数に渡された値は、imutableであるが、inoutを付与することにより、mutableになる
 */
func double(number: inout Int) {
    // var number = number // 通常はvarに代入しなおす
    number *= 2 // これ
    let _ = number * 3
}

/*
 呼び出すときは、&を引数の前につける
 引数は、変数である必要がある
 */
func sample() {
    var n = 10
    double(number: &n)
}

