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
    
    var centralManager: CBCentralManager!
    func onCallBack(call: FlutterMethodCall, result: @escaping FlutterResult) {
        let blutoothDelegate =   SwiftBluetoothEnablePlugin(flutterResult: result);
        os_log("Calling  : %@ ",call.method)
        // os_log("LST State: %@ ",String(blutoothDelegate.lastKnownState ?? CBManagerState.unknown))
        switch call.method {
        case "enable":
            if (blutoothDelegate.lastKnownState == .poweredOn) {
               result("true")
           } else {
               centralManager = CBCentralManager(delegate: blutoothDelegate, queue: nil)
           }
           return;
        default:
            return;
        }
    }
    

}


public class SwiftBluetoothEnablePlugin: NSObject, CBCentralManagerDelegate {

    var lastKnownState: CBManagerState!
    var flutterResult: FlutterResult!
    
    
    init(flutterResult:@escaping FlutterResult){
        self.flutterResult=flutterResult;
    }
    
    public func centralManagerDidUpdateState(_ central: CBCentralManager) {
        lastKnownState = central.state;
        os_log("central.state is: %@", log: .default, type: .debug, _getStateString(state: lastKnownState));
        
        if (lastKnownState == .poweredOn){
            flutterResult("true")
        } else {
            flutterResult("false")
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
