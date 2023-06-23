package com.example.fininfocom;

import android.Manifest;
import android.annotation.SuppressLint;
import android.app.Activity;
import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothManager;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.util.Log;
import androidx.annotation.NonNull;
import androidx.core.app.ActivityCompat;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.common.PluginRegistry.ActivityResultListener;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import io.flutter.plugins.GeneratedPluginRegistrant;

/** FlutterBluePlugin */
public class MainActivity extends FlutterActivity {

  private static final String CHANNEL = "bluetooth_enable";
  private BluetoothAdapter bluetoothAdapter;

  @Override
  public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
    GeneratedPluginRegistrant.registerWith(flutterEngine);
    bluetoothAdapter = BluetoothAdapter.getDefaultAdapter();
    new MethodChannel(
      flutterEngine.getDartExecutor().getBinaryMessenger(),
      CHANNEL
    )
      .setMethodCallHandler(this::methodHandler);
  }

  private static final int REQUEST_ENABLE_BLUETOOTH = 1;

  void methodHandler(MethodCall call, Result result) {
    if (bluetoothAdapter == null && !"isAvailable".equals(call.method)) {
      result.error(
        "bluetooth_unavailable",
        "the device does not have bluetooth",
        null
      );
      return;
    }
    ActivityCompat.requestPermissions(
      this,
      new String[] { Manifest.permission.BLUETOOTH_CONNECT },
      1
    );
    switch (call.method) {
      case "permission_status":
        {
          int status = ActivityCompat.checkSelfPermission(
            this,
            Manifest.permission.BLUETOOTH_CONNECT
          );
          result.success(getStatus(status));
          break;
        }
      case "enable":
        {
          if (bluetoothAdapter.isEnabled()) {
            result.success("Already Enabled");
            return;
          }
          Intent enableBtIntent = new Intent(
            BluetoothAdapter.ACTION_REQUEST_ENABLE
          );
          int status = ActivityCompat.checkSelfPermission(
            this,
            Manifest.permission.BLUETOOTH_CONNECT
          );
          if (status != PackageManager.PERMISSION_GRANTED) {
            result.error("500", "Permission Not Found", status);
            return;
          }
          this.startActivityForResult(enableBtIntent, REQUEST_ENABLE_BLUETOOTH);
          result.success("Enabled");
          break;
        }
    }
  }

  String getStatus(int status) {
    switch (status) {
      case PackageManager.PERMISSION_GRANTED:
        return "GRANTED";
      default:
        return "DENIED";
    }
  }
}
