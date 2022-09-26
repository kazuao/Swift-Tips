//
//  DocumentComment.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2022/08/18.
//

import Foundation

final class DocumentComment {

    /// この行でSummeryを書く
    ///
    /// 3行目はDiscussion
    /// - precondition: ここはメソッドを使う前提条件
    /// - postcondition: 事後条件
    /// - Requires: 必要条件
    /// - Warning: 警告
    /// - Important: 重要
    /// - Attention: 注意
    /// - Bug: バグ
    /// - Note: note
    ///
    /// - parameters:
    ///     - arg1: 引数1
    ///     - arg2: 引数2
    ///
    /// - returns: 戻り値
    /// - throws: エラーの場合
    func normal() {}


    /// リッチコメント
    ///
    /// * 箇条書き
    /// * 箇条書き2
    /// > これはNote
    /// 1. 番号振れる
    /// 2. こんな漢字
    ///     - 1. ネストもできる
    func richComment() {}


    /// サンプルコード
    ///
    /// ```
    /// let hoge = 3
    /// let fuga = "piyo"
    /// ```
    func sampleCode() {}


    /// リンク付きコメント
    ///
    /// [Google](https://www.google.com)
    ///
    func link() {}
}
