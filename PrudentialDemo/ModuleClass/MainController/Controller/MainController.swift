//
//  MainController.swift
//  PrudentialDemo
//
//  Created by Ad on 2021/4/2.
//

import UIKit
class MainController: UIViewController {
    // =================================================================
    //                          属性列表
    // =================================================================
    // MARK: - 属性列表
    private lazy var rulerView: RulerView = {
        let rulerView = RulerView(frame: CGRect(x: 0, y: 150, width: screenWidth, height: 300))
        rulerView.centerY = view.height * 0.5 + 30
        return rulerView
    }()
    // =================================================================
    //                          生命周期
    // =================================================================
    // MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    // =================================================================
    //                          私有方法
    // =================================================================
    // MARK: - 私有方法
    /// UI配置
    private func configUI() {
        view.addSubview(rulerView)
        view.backgroundColor = .white
    }
}
