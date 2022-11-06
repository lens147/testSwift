//
//  ViewController.swift
//  testViewGif
//
//  Created by Leny Bonaton on 30/09/2022.
//

import UIKit
import WebKit






class ViewController: UIViewController {


    
    
    @IBOutlet weak var webview: UIWebView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ApiGif.getGifs().done { gifs in
            print(gifs.count)
        }
        
        webview.loadRequest(NSURLRequest(url: URL(string: "https://media.tenor.com/pshrrKEkHroAAAAC/fml-sylvester.gif")!) as URLRequest)
        // Do any additional setup after loading the view.
        
    }


}

