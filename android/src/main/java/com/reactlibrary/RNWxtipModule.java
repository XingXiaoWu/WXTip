package com.reactlibrary;

import android.app.ProgressDialog;
import android.widget.Toast;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.Callback;

public class RNWxtipModule extends ReactContextBaseJavaModule {

  private final ReactApplicationContext reactContext;
  private ProgressDialog proDialog ;

  public RNWxtipModule(ReactApplicationContext reactContext) {
    super(reactContext);
    this.reactContext = reactContext;
  }

  @Override
  public String getName() {
    return "wxtip";
  }


  @ReactMethod
  public void showToast(String message) {
    final String toastMessage = message;
    final int toastDuration = 2;
    this.getCurrentActivity().runOnUiThread(new Runnable() {
      @Override
      public void run() {
        Toast.makeText(getReactApplicationContext(),toastMessage,toastDuration).show();
      }
    });
  }


  @ReactMethod
  public void showLoading(){
    this.getCurrentActivity().runOnUiThread(new Runnable() {
      @Override
      public void run() {
        proDialog = new ProgressDialog(getCurrentActivity());
        proDialog.setTitle("请稍等");
        proDialog.setMessage("加载中...");
        proDialog.show();
      }
    });
  }


  @ReactMethod
  public void dismissLoading(){
    this.getCurrentActivity().runOnUiThread(new Runnable() {
      @Override
      public void run() {
        proDialog.dismiss();
      }
    });
  }
}