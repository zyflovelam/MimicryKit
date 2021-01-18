//
//  ViewController.swift
//  MimicryKitDemo
//
//  Created by zyf on 2021/1/16.
//

import MimicryKit
import SnapKit
import UIKit

class ViewController: UIViewController {
    var components: [String] = ["Button"]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 41 / 255, green: 45 / 255, blue: 50 / 255, alpha: 1)
        let button = MButton(icon: UIImage(named: "flymode"))
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.size.equalTo(60)
            make.left.equalToSuperview().offset(40)
            make.top.equalToSuperview().offset(100)
        }

        let button2 = MButton(icon: UIImage(named: "bluetooth"))
        view.addSubview(button2)
        button2.snp.makeConstraints { make in
            make.size.equalTo(60)
            make.left.equalTo(button.snp.right).offset(40)
            make.top.equalTo(button.snp.top)
        }
        let buttonHeight: CGFloat = 80
        var appearence = MButton.Appearence.default
        appearence.style = .rectangle(80 * 0.3)
        let button3 = MButton(icon: UIImage(named: "screenMirro"), title: "屏幕镜像", appearence: appearence)
        view.addSubview(button3)
        button3.snp.makeConstraints { (make) in
            make.width.equalTo(140)
            make.height.equalTo(buttonHeight)
            make.left.equalTo(button.snp.left)
            make.top.equalTo(button.snp.bottom).offset(40)
        }
    }
}
