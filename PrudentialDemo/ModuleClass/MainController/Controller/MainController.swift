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
    /// 点击展示的Label
    private lazy var showLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 40))
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor(hexString: "535A60")
        label.alpha = 0
        return label
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
        addHeaderView()
        addBottomButton()
        view.addSubview(rulerView)
        view.backgroundColor = .white
    }
    /// 添加头部视图
    private func addHeaderView() {
        // progressView
        let progressView = ProgressView(current: 1, total: 8, frame: CGRect(x: 0, y: statusBarHeight, width: screenWidth, height: 30))
        view.addSubview(progressView)
        // label
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.textColor = UIColor(hexString: "535A60")
        label.text = "How old are you?"
        label.sizeToFit()
        label.x = 20
        label.y = progressView.bottom + 30
        view.addSubview(label)
    }
    /// 添加底部按钮
    private func addBottomButton() {
        let sideMargin: CGFloat = 45
        let bottomMargin: CGFloat = CGFloat(safeBottomHeight + 30)
        let buttonHeight: CGFloat = 60
        let buttonWidth = screenWidth - 2 * sideMargin
        let button = UIButton(frame: CGRect(x: sideMargin, y: view.height - bottomMargin - buttonHeight, width: buttonWidth, height: buttonHeight))
        button.backgroundColor = UIColor(hexString: "7BCCD6")
        button.setTitle("Continue", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        button.roundCorners(radius: buttonHeight * 0.5)
        button.addTarget(self, action: #selector(bottomButtonClick), for: .touchUpInside)
        view.addSubview(button)
        showLabel.y = button.y - 15 - showLabel.height
        view.addSubview(showLabel)
    }
    /// 底部按钮点击事件
    @objc private func bottomButtonClick() {
        self.showLabel.text = "Currently selected:\(rulerView.getCurrentNum())"
        UIView.animate(withDuration: 0.5) {
            self.showLabel.alpha = 1
        } completion: { (_) in
            UIView.animate(withDuration: 2) {
                self.showLabel.alpha = 0
            }
        }
    }
}
