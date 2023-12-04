//
//  ViewController.swift
//  GreenCycle
//
//  Created by 김민경 on 11/29/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textFieldBox: UIView!
    @IBOutlet weak var sendBtn: UIView!
    @IBOutlet weak var TextView: UITextView!
    
    
    @IBAction func enterDidTap(_ sender: Any) {
        
        guard let text = TextView.text, !text.isEmpty else {
            // Handle the case where TextView.text is empty
            return
        }
        
        guard let url = URL(string: "http://localhost:8080/api/createUser/\(text)") else {
            // Handle the case where the URL is invalid
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST" // You can change this depending on your API requirements

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            // Handle the response from the server
            if let error = error {
                print("Error: \(error)")
            } else if let data = data {
                // Process the data received from the server (if needed)
                print("Response: \(String(data: data, encoding: .utf8) ?? "")")
            }
        }.resume()
        
        // Present the MapCont view controller
        guard let mapCont = self.storyboard?.instantiateViewController(withIdentifier: "MapCont") as? MapCont else {
            return
        }
        mapCont.modalPresentationStyle = .fullScreen
        present(mapCont, animated: true, completion: nil)
        
    }
    
    
    override func viewDidLoad() {
        
        textFieldBox.layer.cornerRadius = 20
        textFieldBox.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner)
        
        textFieldBox.layer.shadowOpacity = 1 // 그림자 불투명도 지정하기
        textFieldBox.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor // 그림자 색상 지정하기
        textFieldBox.layer.shadowOffset = CGSize(width: 0, height: -8) // 그림자 위치 지정하기
        textFieldBox.layer.shadowRadius = 24 // 그림자 흐림 지정하기
        textFieldBox.layer.masksToBounds = false
        textFieldBox.clipsToBounds = false
        
        sendBtn.layer.cornerRadius = 20
        sendBtn.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner)
        
        TextView.delegate = self
                
        //처음 화면이 로드되었을 때 플레이스 홀더처럼 보이게끔 만들어주기
        TextView.text = "NickName"
        TextView.textColor = UIColor.lightGray
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.TextView.resignFirstResponder()
        }


}

extension ViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        if TextView.text.isEmpty {
            TextView.text =  "NickName"
            TextView.textColor = UIColor.lightGray
        }

    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if TextView.textColor == UIColor.lightGray {
            TextView.text = nil
            TextView.textColor = UIColor.black
        }
    }
}
