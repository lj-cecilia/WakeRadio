////
////  StreamDetailsView.swift
////  WakeRadio
////
////  Created by Cecilia on 4/14/24.
////
//
//import Foundation
//import UIKit
//
//class StreamDetailsView: UIViewController {
//    @IBOutlet weak var DJName: UITextField!
//    @IBOutlet weak var DJStyle: UITextField!
//    @IBOutlet weak var ListenersCurrent: UITextField!
//    @IBOutlet weak var ListenersPeak: UITextField!
//    
//    var djName : String = "Rachel"
//    var djStyle : String = "Mellow, wistful music"
//    var listenersCurrent : Int = 0
//    var listenersPeak : Int = 0
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        print("Hello CC")
//        
//        DJName.text = "DJ Name: \(djName)"
//        DJStyle.text = "DJ Style: \(djStyle)"
//        ListenersCurrent.text = "Listeners(current): \(listenersCurrent)"
//        ListenersPeak.text = "Listeners(peak): \(listenersPeak)"
//    }
//}
//
import Foundation
import UIKit
import SwiftSoup

class StreamDetailsView: UIViewController {
    @IBOutlet weak var DJName: UITextField!
    @IBOutlet weak var DJStyle: UITextField!
    @IBOutlet weak var ListenersCurrent: UITextField!
    @IBOutlet weak var ListenersPeak: UITextField!
    
    var djName: String = "Rachel"
    var djStyle: String = "Mellow, wistful music"
    var listenersCurrent: String = "0"
    var listenersPeak: String = "0"

    override func viewDidLoad() {
        super.viewDidLoad()
        //default dj info values displayed
        DJName.text = "DJ Name: \(djName)"
        DJStyle.text = "DJ Style: \(djStyle)"
        ListenersCurrent.text = "Listeners(current): \(listenersCurrent)"
        ListenersPeak.text = "Listeners(peak): \(listenersPeak)"
        
        //dynamicly update the stream stats, the current and peak listeners
        guard let url = URL(string: "http://152.17.49.84:8000") else { return }
        
        let myURLString = "http://152.17.49.84:8000"
        guard let myURL = URL(string: myURLString) else {
            print("Error: \(myURLString) doesn't seem to be a valid URL")
            return
        }

        do {
            let html = try String(contentsOf: myURL, encoding: .ascii)
            //print to the console
            print("HTML : \(html)")
            
            let searchString1 = "Listeners (current):</td><td class=\"streamstats\">"
            if let range = html.range(of: searchString1) {
                let numberStartIndex = html.index(range.upperBound, offsetBy: 0)
                let numberEndIndex = html.index(numberStartIndex, offsetBy: 1)  // Assuming the number is one digit, if two or more then change
                let currentListeners = html[numberStartIndex..<numberEndIndex]
                ListenersCurrent.text = "Listeners(current): \(currentListeners)"
                print("Current listeners: \(currentListeners)")
            } else {
                print("Search string not found")
            }
            
            let searchString2 = "Listeners (peak):</td><td class=\"streamstats\">"
            if let range = html.range(of: searchString2) {
                let numberStartIndex = html.index(range.upperBound, offsetBy: 0)
                let numberEndIndex = html.index(numberStartIndex, offsetBy: 2)  // Assuming the number is two digit, if three or more then change
                let currentListeners = html[numberStartIndex..<numberEndIndex]
                ListenersPeak.text = "Listeners(peak): \(currentListeners)"
                print("Current listeners: \(currentListeners)")
            } else {
                print("Search string not found")
            }
        } catch let error {
            print("Error: \(error)")
        }
        
//        html that should be parsed to get the current and peak listeners
//        <tr><td>Listeners (current):</td><td class="streamstats">1</td></tr>
//        <tr><td>Listeners (peak):</td><td class="streamstats">33</td></tr>
    }
}
