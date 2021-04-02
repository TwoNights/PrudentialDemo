//
//  ProgressView.swift
//  PrudentialDemo
//
//  Created by Ad on 2021/4/2.
//

import Foundation
import UIKit
private let labelWidth: CGFloat = 60
class ProgressView: UIView {
    // =================================================================
    //                          属性列表
    // =================================================================
    // MARK: - 属性列表
    private lazy var label: UILabel = {
        let label = UILabel(frame: CGRect(x: width - labelWidth, y: 0, width: labelWidth, height: height))
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor(hexString: "535A60")
        label.textAlignment = .center
        return label
    }()
    private lazy var outLine: UIView = {
        let outLine = UIView(frame: CGRect(x: labelWidth, y: 0, width: width - 2 * labelWidth, height: 10))
        outLine.centerY = 0.5 * height
        outLine.backgroundColor = UIColor(hexString: "F0F0F0")
        outLine.roundCorners(radius: outLine.height * 0.5)
        return outLine
    }()
    private lazy var inLine: UIView = {
        let inLine = UIView(frame: outLine.frame)
        inLine.backgroundColor = UIColor(hexString: "7BCCD6")
        return inLine
    }()
    // =================================================================
    //                          公开方法
    // =================================================================
    // MARK: - 公开方法
    /// 初始化方法
    /// - Parameters:
    ///   - current: 当前进度
    ///   - total: 总进度
    ///   - frame: frame
    init(current: UInt, total: UInt, frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        addSubview(outLine)
        if current > 0 {
            addSubview(inLine)
            inLine.width = CGFloat(current) / CGFloat(total) * inLine.width
            inLine.roundCorners(radius: inLine.height * 0.5)
        }
        label.text = "\(current)/\(total)"
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
