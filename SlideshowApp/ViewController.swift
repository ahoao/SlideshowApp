//
//  ViewController.swift
//  SlideshowApp
//
//  Created by Ao Nagasawa on 2020/08/07.
//  Copyright © 2020 Ao.Nagasawa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
    }
    
    @IBOutlet weak var imageView: UIImageView!
    var selectedImage: UIImage?
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var switchButton: UIButton!
    
    // 配列に指定するindex番号を宣言
    var nowIndex:Int = 0
    //スライドショーに使用するタイマーを宣言
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //初期画面
        //バンドルした画像ファイルを読み込み
        //Image Viewに画像を設定
        let selectedImage = UIImage(named: "cat1.jpg")
        imageView.image = selectedImage
    }
    
    // 表示している画像の番号
    var displayImageNo = 0
    
    // 画像の名前の配列
    var imageNameArray = ["cat1.jpg", "cat2.jpg", "cat3.jpg", "cat4.jpg", "cat5.jpg"]
    
    // 表示している画像の番号を元に画像を表示する
    func displayImage() {
        
        // 表示している画像の番号から名前を取り出し
        let name = imageNameArray[displayImageNo]
        
        // 画像を読み込み
        let selectedImage = UIImage(named: name)
        
        // Image Viewに読み込んだ画像をセット
        imageView.image = selectedImage
    }
    
    @IBAction func nextButtonTap(_ sender: Any) {
        if displayImageNo < imageNameArray.count - 1 {
            // 表示している画像の番号を１増やす
            displayImageNo += 1
            //表示している画像の番号をもとに画像を表示する
            displayImage()
        } else {
            displayImageNo = 0
            displayImage()
        }
        
    }
    
    @IBAction func backButtonTap(_ sender: Any) {
        if displayImageNo >= 1 && displayImageNo <= imageNameArray.count - 1 {
            // 表示している画像の番号を１減らす
            displayImageNo -= 1
            //表示している画像の番号をもとに画像を表示する
            displayImage()
        } else {
            displayImageNo = imageNameArray.count - 1
            displayImage()
        }
        
    }
    
    @IBAction func switchButtonTap(_ sender: Any) {
        backButton.isEnabled = false
        nextButton.isEnabled = false
        //再生中か停止しているかを判定
        if (timer == nil){
            
            //タイマーをセットする
            timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(changeImage), userInfo: nil, repeats: true)
            //ボタンの名前を停止に変える
            switchButton.setTitle("停止", for: .normal)
            
        } else {
            // 停止時の処理を実装
            backButton.isEnabled = true
            nextButton.isEnabled = true
            // タイマーを停止する
            timer.invalidate()
            
            //タイマーを削除しておく
            timer = nil
            //ボタンの名前を再生にしておく
            switchButton.setTitle("再生", for: .normal)
            
        }
        
    }
    
    @objc func changeImage(){
        if displayImageNo < imageNameArray.count - 1 {
            // 表示している画像の番号を１増やす
            displayImageNo += 1
            //表示している画像の番号をもとに画像を表示する
            displayImage()
        } else {
            displayImageNo = 0
            displayImage()
        }
      //偏移したときにタイマーを止め、同じ画像が出るようにする
      backButton.isEnabled = true
      nextButton.isEnabled = true
      // タイマーを停止する
      timer.invalidate()
      
      //タイマーを削除しておく
      timer = nil
      //ボタンの名前を再生にしておく
      switchButton.setTitle("再生", for: .normal)
    }
    
    func tableView(_ table: UITableView,didSelectRowAt indexPath: IndexPath) {
        // [indexPath.row] から画像名を探し、UImage を設定
        selectedImage = UIImage(named: imageNameArray[indexPath.row] )
        if selectedImage != nil {
            // SubViewController へ遷移するために Segue を呼び出す
            performSegue(withIdentifier: "toSecondViewController",sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // segueから遷移先のResultViewControllerを取得する
        let secondViewController = segue.destination as! SecondViewController
        
        
        secondViewController.catImage = imageNameArray[displayImageNo]
    }
}



