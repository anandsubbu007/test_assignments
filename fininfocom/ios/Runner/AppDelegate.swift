import UIKit
import Flutter
import CoreBluetooth
import os.log

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController

    let channel = FlutterMethodChannel(name: "bluetooth_enable", binaryMessenger: controller.binaryMessenger)
    channel.setMethodCallHandler(onCallBack)
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
 
    func onCallBack(call: FlutterMethodCall, result: @escaping FlutterResult) {

        os_log("Calling  : %@ ",call.method)
        switch call.method {
        case "enable":
            let blutoothDelegate =   SwiftBluetoothEnablePlugin(flutterResult: result);
            let dd = "\(String(describing: blutoothDelegate.lastKnownState))";
             os_log("LST State: %@ ",dd)
            if (blutoothDelegate.lastKnownState == .poweredOn) {
               result("true")
           } else {
           if(dd){
               result(dd)
           }else{
                          result("No Action found")
}
           }
           return;
        default:
            return;
        }
    }
}


public class SwiftBluetoothEnablePlugin: NSObject, CBCentralManagerDelegate {
    var centralManager: CBCentralManager!
    var lastKnownState: CBManagerState!
    var flutterResult: FlutterResult!
    
    
      init(flutterResult:@escaping FlutterResult){
        self.flutterResult=flutterResult;
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    public func centralManagerDidUpdateState(_ central: CBCentralManager) {
        lastKnownState = central.state;
        os_log("central.state is: %@", log: .default, type: .debug, _getStateString(state: lastKnownState));
        
        if (lastKnownState == .poweredOn){
            flutterResult("Turned On")
        } else {
            flutterResult("Unknown Issue Occurs")
        }
    }

    private func _getStateString(state: CBManagerState) -> String {
        switch (state) {
        case .unknown:
            return ".unknown";
        case .resetting:
            return ".resetting";
        case .unsupported:
            return ".unsupported";
        case .unauthorized:
            return ".unauthorized";
        case .poweredOff:
            return ".poweredOff";
        case .poweredOn:
            return ".poweredOn";
        @unknown default:
            return "";
        }
    }
}
