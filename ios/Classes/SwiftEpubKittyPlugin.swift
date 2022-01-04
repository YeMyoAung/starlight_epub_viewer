import Flutter
import UIKit
import Foundation
import FolioReaderKit
import Realm
import RealmSwift



public class SwiftEpubViewerPlugin: NSObject, FlutterPlugin,FolioReaderPageDelegate,FlutterStreamHandler {
    
    let folioReader = FolioReader()
    static var pageResult: FlutterResult? = nil

    var config: EpubConfig?
    
    
    public static func register(with registrar: FlutterPluginRegistrar) {
      let channel = FlutterMethodChannel(name: "starlight_epub", binaryMessenger: registrar.messenger())
      let instance = SwiftEpubViewerPlugin()
      
      registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
      

      switch call.method {
      case "setConfig":
          
        let arguments = call.arguments as![String:Any]
        let scrollDirection = arguments["scrollDirection"] as! String
        let color = arguments["themeColor"] as! String
        let allowSharing = arguments["allowSharing"] as! Bool
        let setShowRemainingIndicator = arguments["setShowRemainingIndicator"] as! Bool
        let enableTts = arguments["enableTts"] as! Bool
        let nightMode = arguments["nightMode"] as! Bool
        self.config = EpubConfig.init(Identifier: "com.starlight.epubviewer",tintColor: color,allowSharing:
                                        allowSharing,scrollDirection: scrollDirection, setShowRemainingIndicator: setShowRemainingIndicator, enableTts: enableTts, nightMode: nightMode)

        break
      case "open":
           setPageHandler()
          let arguments = call.arguments as![String:Any]
          let bookPath = arguments["bookPath"] as! String
          self.open(epubPath: bookPath)

          break
      case "close":
          self.close()
          break
      default:
          break
      }
    }
      
      private func setPageHandler(){
        
      }
      
      public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
          SwiftEpubViewerPlugin.pageResult = events
          return nil
      }

      public func onCancel(withArguments arguments: Any?) -> FlutterError? {
          return nil
      }
      
      
      fileprivate func open(epubPath: String) {
           if epubPath == "" {
              return
          }

          let readerVc = UIApplication.shared.keyWindow!.rootViewController ?? UIViewController()
          folioReader.presentReader(parentViewController: readerVc, withEpubPath: epubPath, andConfig: self.config!.config)
          folioReader.readerCenter?.pageDelegate = self
      }

      public func pageWillLoad(_ page: FolioReaderPage) {
          if (SwiftEpubViewerPlugin.pageResult != nil){
              SwiftEpubViewerPlugin.pageResult!(String(page.pageNumber))
          }

      }
      
      private func close(){
          folioReader.readerContainer?.dismiss(animated: true, completion: nil)
      }

  }
