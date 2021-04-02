//
//  RulerView.swift
//  PrudentialDemo
//
//  Created by Ad on 2021/4/2.
//
import Foundation
import UIKit
// =================================================================
//                        RulerViewConfig
// =================================================================
// MARK: - RulerViewConfig
struct RulerViewConfig {
    // 取值配置
    var min: Int = 18                                               // 最小值
    var max: Int = 128                                              // 最大值
    var deafault: Int = 25                                          // 默认选中值
    // circle配置
    var circleRadius: CGFloat = 50                                  // 圆形半径
    var cricleColor: UIColor = UIColor(hexString: "ECF4FB")         // 圆形颜色
    var cricleFont: UIFont = UIFont.boldSystemFont(ofSize: 32)      // 圆形文字字体
    // text配置
    var textColor: UIColor = UIColor(hexString: "535A60")           // 文字颜色
    var textFont: UIFont = UIFont.boldSystemFont(ofSize: 14)        // 文字字体
    // Line配置
    var margin: CGFloat = 15                                        // 间距
    var lineWidth: CGFloat = 2                                      // 刻度线宽度
    var longLineHeight: CGFloat = 15                                // 长线高度
    var shortLineHeight: CGFloat = 10                               // 短线高度
    var lineColor: UIColor = UIColor(hexString: "D2D9DF")           // 刻度线颜色
    var centerLineColor: UIColor = UIColor(hexString: "7BCCD6")     // 分割线颜色
}
// =================================================================
//                              RulerView
// =================================================================
// MARK: - RulerView
class RulerView: UIView {
    // =================================================================
    //                              属性列表
    // =================================================================
    // MARK: - 属性列表
    /// Ruler配置
    private var config: RulerViewConfig
    /// 总共刻度数量
    private var totalCount: Int = 0
    /// 间距+lineWidth
    private var totalMargin: CGFloat = 1
    /// 当前显示数字Label
    private lazy var currentNumLabel: UILabel = {
        let currentNumLabel = UILabel()
        currentNumLabel.textAlignment = .center
        currentNumLabel.frame = CGRect(x: 0, y: 0, width: screenWidth, height: config.circleRadius * 2)
        currentNumLabel.font = config.cricleFont
        currentNumLabel.text = "\(config.deafault)"
        return currentNumLabel
    }()
    /// scrollView
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: bounds)
        scrollView.contentInset = UIEdgeInsets(top: 0, left: width * 0.5, bottom: 0, right: width * 0.5)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        scrollView.delegate = self
        return scrollView
    }()
    // =================================================================
    //                              公开方法
    // =================================================================
    // MARK: - 公开方法
    /// 初始化
    /// - Parameters:
    ///   - config: 配置
    ///   - frame: frame
    init(config: RulerViewConfig = RulerViewConfig(), frame: CGRect) {
        self.config = config
        super.init(frame: frame)
        configData()
        configUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /// 获取当前数字
    func getCurrentNum() -> String {
        return currentNumLabel.text ?? "\(config.min)"
    }
    // =================================================================
    //                              私有方法
    // =================================================================
    // MARK: - 私有方法
    /// Data初始化
    private func configData() {
        guard (config.max + 1) - config.min > 0 else {
            #if DEBUG
            fatalError("config输入错误")
            #endif
            return
        }
        totalCount = (config.max + 1) - config.min
        totalMargin = config.lineWidth + config.margin
    }
    /// UI初始化
    private func configUI() {
        addTopView()
        addScrollView()
        addCenterLine()
        addAlphaView()
    }
    /// 添加头部视图
    private func addTopView() {
        // 绘制圆
        let arcCenter = CGPoint(x: width/2.0, y: config.circleRadius)
        let circlePath = UIBezierPath(arcCenter: arcCenter, radius: config.circleRadius, startAngle: 0, endAngle: .pi * 2, clockwise: true)
        let innerCircleLayer = CAShapeLayer()
        innerCircleLayer.fillColor = config.cricleColor.cgColor
        innerCircleLayer.path = circlePath.cgPath
        layer.insertSublayer(innerCircleLayer, at: 0)
        // 绘制三角
        let polygon = UIBezierPath()
        polygon.move(to: CGPoint(x: (screenWidth * 0.5) - 15, y: (config.circleRadius * 2) - 5))
        polygon.addLine(to: CGPoint(x: screenWidth * 0.5, y: (config.circleRadius * 2) + 10))
        polygon.addLine(to: CGPoint(x: (screenWidth * 0.5) + 15, y: (config.circleRadius * 2) - 5))
        polygon.fill()
        let polygonLayer = CAShapeLayer()
        polygonLayer.fillColor = config.cricleColor.cgColor
        polygonLayer.path = polygon.cgPath
        layer.insertSublayer(polygonLayer, at: 0)
        // NumLabel
        addSubview(currentNumLabel)
    }
    /// 添加ScrollView
    private func addScrollView() {
        // scrollView布局
        addSubview(scrollView)
        scrollView.contentSize.width = CGFloat(totalCount - 1) * totalMargin + config.lineWidth
        scrollView.setContentOffset(CGPoint(x: 0.5 * (config.lineWidth - width), y: 0), animated: false)
        scrollView.y = (config.circleRadius * 2) + 20
        scrollView.height = height - scrollView.y
        // 刻度线
        for i in 0..<totalCount {
            let line = UIView(frame: CGRect(x: CGFloat(i) * totalMargin, y: 10, width: config.lineWidth, height: config.shortLineHeight))
            if i%10 == 0 {
                line.height = config.longLineHeight
                // textLayer
                let textLayer = CATextLayer()
                textLayer.frame = CGRect(x: line.x - 20, y: line.bottom + 10, width: config.lineWidth + 40, height: 20)
                textLayer.contentsScale = UIScreen.main.scale
                textLayer.alignmentMode = .center
                let textAttr: [NSAttributedString.Key: Any] = [
                    .foregroundColor: config.textColor,
                    .font: config.textFont
                ]
                textLayer.string =  NSAttributedString(string: "\(i + config.min)", attributes: textAttr)
                scrollView.layer.addSublayer(textLayer)
            }
            line.backgroundColor = config.lineColor
            scrollView.addSubview(line)
            // 滚动到默认数据处
            if (i + config.min) == config.deafault {
                scrollView.setContentOffset(CGPoint(x: line.centerX - scrollView.contentInset.left, y: 0), animated: false)
            }
        }
        // bottomLine
        let bottomLine = UIView(frame: CGRect(x: 0, y: config.longLineHeight + 10, width: scrollView.contentSize.width, height: 3))
        bottomLine.backgroundColor = config.lineColor
        scrollView.addSubview(bottomLine)
    }
    /// 添加中心线
    private func addCenterLine() {
        let centerLine = UIView()
        centerLine.width = config.lineWidth + 2
        centerLine.height = config.longLineHeight + 30
        centerLine.centerX = centerX
        centerLine.y = scrollView.y
        centerLine.backgroundColor = config.centerLineColor
        centerLine.roundCorners(radius: centerLine.width * 0.5)
        addSubview(centerLine)
    }
    /// 添加透明视图
    private func addAlphaView() {
        let alphaWidth: CGFloat = 80.0
        /// 前段
        let leadingView = UIView(frame: CGRect(x: 0, y: 0, width: alphaWidth, height: height))
        addSubview(leadingView)
        let colorOne = UIColor.white.withAlphaComponent(1).cgColor
        let colorTwo = UIColor.white.withAlphaComponent(0).cgColor
        let colors = [colorOne, colorTwo]
        let leadingGradient = CAGradientLayer()
        leadingGradient.startPoint = CGPoint(x: 0, y: 0)
        leadingGradient.endPoint = CGPoint(x: 1, y: 0)
        leadingGradient.colors = colors
        leadingGradient.frame = CGRect(x: 0, y: 0, width: alphaWidth, height: height)
        leadingView.layer.insertSublayer(leadingGradient, at: 0)
        /// 后段
        let trailingView = UIView(frame: CGRect(x: width - alphaWidth, y: 0, width: alphaWidth, height: height))
        addSubview(trailingView)
        let trailingGradient = CAGradientLayer()
        trailingGradient.startPoint = CGPoint(x: 1, y: 0)
        trailingGradient.endPoint = CGPoint(x: 0, y: 0)
        trailingGradient.colors = colors
        trailingGradient.frame = CGRect(x: 0, y: 0, width: alphaWidth, height: height)
        trailingView.layer.insertSublayer(trailingGradient, at: 0)
    }
}
// =================================================================
//                       scrollViewDelegate
// =================================================================
// MARK: - scrollViewDelegate
extension RulerView: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        var targetContentOffsetX = targetContentOffset.pointee.x + (scrollView.contentInset.left - 0.5 * config.lineWidth)
        if targetContentOffsetX.truncatingRemainder(dividingBy: totalMargin) != 0 {
            if velocity.x > 0 {
                targetContentOffsetX += (totalMargin - targetContentOffsetX.truncatingRemainder(dividingBy: totalMargin))
            } else {
                targetContentOffsetX -= targetContentOffsetX.truncatingRemainder(dividingBy: totalMargin)
            }
        }
        targetContentOffset.pointee.x = targetContentOffsetX - (scrollView.contentInset.left - 0.5 * config.lineWidth)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let margin = scrollView.contentInset.left - 0.5 * config.lineWidth
        let offsetX = scrollView.contentOffset.x + 0.5 * totalMargin + margin
        currentNumLabel.text = "\(Int(offsetX/totalMargin) + config.min)"
    }
}
