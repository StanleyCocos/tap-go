package com.example.tap_go_sdk

import android.app.Activity
import android.content.Intent
import androidx.annotation.NonNull
import com.hktpayment.tapngosdk.TapNGoPayResult
import com.hktpayment.tapngosdk.utils.Logger

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry
import java.lang.ref.WeakReference

/** TapGoSdkPlugin */
class TapGoSdkPlugin : FlutterPlugin, MethodCallHandler, ActivityAware,
    PluginRegistry.ActivityResultListener {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private var activityRef: WeakReference<Activity>? = null

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "tap_go_sdk")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "init" -> {
                val appId: String = call.argument<String>("appId") ?: ""
                val apiKey: String = call.argument<String>("apiKey") ?: ""
                val publicKey: String = call.argument<String>("publicKey") ?: ""
                TapGoManager.init(appId, apiKey, publicKey, channel)
                result.success(null)
            }
            "singlePay" -> {
                val merTradeNo: String = call.argument<String>("merTradeNo") ?: ""
                val totalPrice: String = call.argument<String>("totalPrice") ?: ""
                val remark: String = call.argument<String>("remark") ?: ""
                TapGoManager.doSinglePayment(merTradeNo, totalPrice, remark)
                result.success(null)
            }
            "recurrentPay" -> {
                val merTradeNo: String = call.argument<String>("merTradeNo") ?: ""
                val remark: String = call.argument<String>("remark") ?: ""
                TapGoManager.doRecurrentPayment(merTradeNo, remark)
                result.success(null)
            }
            "singleAndRecurrentPay" -> {
                val merTradeNo: String = call.argument<String>("merTradeNo") ?: ""
                val totalPrice: String = call.argument<String>("totalPrice") ?: ""
                val remark: String = call.argument<String>("remark") ?: ""
                TapGoManager.doSingleRecurrentPayment(merTradeNo, totalPrice, remark)
                result.success(null)
            }
            "getSdkVersion" -> {
                val version: String = TapGoManager.getSdkVersion()
                result.success(version)
            }
            "setSandBoxModeEnable" -> {
                val enable: Boolean = call.argument<Boolean>("enable") ?: false
                TapGoManager.setSandboxMode(enable)
                result.success(null)
            }
            else -> {
                result.notImplemented()
            }
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activityRef = WeakReference(binding.activity)
        TapGoManager.bindActivity(activityRef!!)
        binding.addActivityResultListener(this)
    }

    override fun onDetachedFromActivityForConfigChanges() {
        activityRef = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activityRef = WeakReference(binding.activity)
        TapGoManager.bindActivity(activityRef!!)
        binding.addActivityResultListener(this)
    }

    override fun onDetachedFromActivity() {
        activityRef = null
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
        Logger.d("Received onActivityResult")
        if (requestCode == 100) {
            val result: TapNGoPayResult
            if (resultCode == -1) {
                result = TapNGoPayResult(data, activityRef?.get()?.application)
                if (result.resultCode != null && result.resultCode == "0") {
                    Logger.d("onPaymentSuccess, result code:" + result.resultCode)
                    TapGoManager.onPaymentSuccess(result)
                } else {
                    Logger.d("onPaymentFail, result code:" + result.resultCode)
                    TapGoManager.onPaymentFail(result)
                }
            } else {
                result = TapNGoPayResult("SA998", activityRef?.get()?.application)
                Logger.d("onPaymentFail, result code:" + result.resultCode)
                TapGoManager.onPaymentFail(result)
            }
        }
        return false
    }
}
