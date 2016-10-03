import UIKit

class ViewController: UIViewController {
    
    let photos = ["IMG_1010","IMG_1694","IMG_1718","IMG_1963","IMG_2131"]
    
    var barHeight: CGFloat = 0.0
    var displayWidth: CGFloat = 0.0
    var displayHeight: CGFloat = 0.0
    var imageView: UIImageView!
    var timer: NSTimer!
    var slider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // statusbarの高さ取得
        barHeight = UIApplication.sharedApplication().statusBarFrame.size.height
        
        // viewのサイズ取得
        displayWidth = self.view.frame.width
        displayHeight = self.view.frame.height
        
        // 一枚目の原稿を読み込む
        let image:UIImage! = UIImage(named: photos[0])
        // 画像のアスペクト比を出して横幅いっぱいに画像を表示する
        let aspect:CGFloat = image.size.height / image.size.width
        imageView = UIImageView(frame: CGRect(x: 0, y: barHeight + ((displayHeight - barHeight - displayWidth * aspect) / 2), width: displayWidth, height: displayWidth * aspect))
        imageView.image = image;
        self.view.addSubview(imageView)
        
        // Sliderを作成する.
        slider = UISlider(frame: CGRectMake(0, 0, displayWidth*0.9, 20))
        slider.layer.position = CGPointMake(displayWidth / 2, displayHeight - 30)
        slider.backgroundColor = UIColor.whiteColor()
        slider.layer.cornerRadius = 10.0
        slider.layer.masksToBounds = false
        
        // 目盛の最小値と最大値を設定する.
        slider.minimumValue = 0
        slider.maximumValue = Float(manuscripts.count) - 1.0
        
        // Sliderの初期位置を設定する.
        slider.value = 0
        
        // Sliderの現在位置より右のTintカラーを変える.
        slider.maximumTrackTintColor = UIColor.grayColor()
        
        // Sliderの現在位置より左のTintカラーを変える.
        slider.minimumTrackTintColor = UIColor.greenColor()
        
        // 値が変化した時
        slider.addTarget(self, action: "onChangeValueSlider:", forControlEvents: UIControlEvents.ValueChanged)
        // 指を付けた時
        slider.addTarget(self, action: "timerStart:", forControlEvents: UIControlEvents.TouchUpInside)
        // 指を離した時
        slider.addTarget(self, action: "timerStop:", forControlEvents: UIControlEvents.TouchDown)
        
        self.view.addSubview(slider)
        
        timerInitialized()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func timerInitialized () {
        timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: Selector("nextPage"), userInfo: nil, repeats: true)
    }
    
    func timerStart (sender : UISlider) {
        if (!timer.valid) {
            timerInitialized()
        }
    }
    
    func timerStop (sender : UISlider){
        if (timer.valid) {
            timer.invalidate()
        }
    }
    
    // Sliderの値が変わった時に呼ばれるメソッド
    func onChangeValueSlider(sender : UISlider){
        let index = Int(sender.value)
        
        // 再びUIView処理済み画像を設定する.
        imageView.image = UIImage(named: photos[index])
        
        // 再描画をおこなう.
        imageView.setNeedsDisplay()
    }
    
    func nextPage (){
        slider.value++
        onChangeValueSlider(slider)
    }
}

