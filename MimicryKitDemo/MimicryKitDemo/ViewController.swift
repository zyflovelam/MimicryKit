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
        let button = MButton()
            .icon(UIImage(named: "flymode"))
            .style(.circle)
            .addTo(view)
        button.snp.makeConstraints { make in
            make.size.equalTo(60)
            make.left.equalToSuperview().offset(40)
            make.top.equalToSuperview().offset(100)
        }

        let button2 = MButton()
            .icon("bluetooth")
            .style(.circle)
            .addTo(view)
        button2.snp.makeConstraints { make in
            make.size.equalTo(60)
            make.left.equalTo(button.snp.right).offset(40)
            make.top.equalTo(button.snp.top)
        }
        let buttonHeight: CGFloat = 80
        let button3 = MButton()
            .icon("screenMirro")
            .title("屏幕镜像")
            .style(.rectangle(corner: 80 * 0.3))
            .addTo(view)
        button3.snp.makeConstraints { make in
            make.width.equalTo(140)
            make.height.equalTo(buttonHeight)
            make.left.equalTo(button.snp.left)
            make.top.equalTo(button.snp.bottom).offset(40)
        }

        let card = MCard()
            .style(.rectangle(corner: 10))
            .addTo(view)
        card.snp.makeConstraints { make in
            make.width.equalTo(140)
            make.height.equalTo(80)
            make.top.equalTo(button3.snp.bottom).offset(40)
            make.left.equalToSuperview().offset(40)
        }

        let card2 = MCard()
            .style(.circle)
            .addTo(view)
        card2.snp.makeConstraints { make in
            make.size.equalTo(80)
            make.top.equalTo(card.snp.bottom).offset(40)
            make.left.equalToSuperview().offset(40)
        }

        let progressBar = MProgressBar()
            .progress(0.5)
            .cornerSize(10)
            .addTo(view)
        progressBar.snp.makeConstraints { make in
            make.width.equalTo(140)
            make.height.equalTo(20)
            make.top.equalTo(card2.snp.bottom).offset(40)
            make.left.equalToSuperview().offset(40)
        }

        let progressBar1 = MProgressBar()
            .progress(0.7)
            .cornerSize(2)
            .addTo(view)
        progressBar1.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(4)
            make.top.equalTo(progressBar.snp.bottom).offset(40)
            make.left.equalToSuperview().offset(40)
        }

        let progressBar3 = MProgressBar()
            .editable(true)
            .cornerSize(20)
            .direction(.vertical)
            .addTo(view)
        progressBar3.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.height.equalTo(220)
            make.top.equalTo(card2.snp.top)
            make.right.equalToSuperview().offset(-40)
        }
    }
}
