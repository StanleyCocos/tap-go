package com.example.tap_go_sdk

import android.app.Activity
import com.hktpayment.tapngosdk.TapNGoPayResult
import com.hktpayment.tapngosdk.TapNGoPayment
import com.hktpayment.tapngosdk.TapNGoSdkSettings
import com.hktpayment.tapngosdk.elements.PayStateValidationResult
import com.hktpayment.tapngosdk.exception.DoPaymentException
import com.hktpayment.tapngosdk.listener.IPaymentAuthFailListener
import com.hktpayment.tapngosdk.utils.Logger
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.DelicateCoroutinesApi
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch
import java.lang.ref.WeakReference

object TapGoManager {

    private const val PAY_CURRENCY = "HKD"
    private const val NOTIFY_URL = ""

    private lateinit var appId: String
    private lateinit var apiKey: String
    private lateinit var publicKey: String
    private lateinit var channel: MethodChannel
    private lateinit var activityRef: WeakReference<Activity>

    fun init(appId: String, apiKey: String, publicKey: String, channel: MethodChannel) {
        this.appId = appId
        this.apiKey = apiKey
        this.publicKey = publicKey
        this.channel = channel
    }

    fun bindActivity(activityRef: WeakReference<Activity>) {
        this.activityRef = activityRef
    }

    fun doSinglePayment(merTradeNo: String, totalPrice: String, remark: String) {
        val payment: TapNGoPayment = TapNGoPayment(appId, apiKey, publicKey)
        payment.setSinglePayment(merTradeNo, totalPrice, PAY_CURRENCY, remark, NOTIFY_URL)
        doPayment(payment)
    }

    fun doRecurrentPayment(merTradeNo: String, remark: String) {
        val payment: TapNGoPayment = TapNGoPayment(appId, apiKey, publicKey)
        payment.setRecurrentPayment(merTradeNo, PAY_CURRENCY, remark)
        doPayment(payment)
    }

    fun doSingleRecurrentPayment(merTradeNo: String, totalPrice: String, remark: String) {
        val payment: TapNGoPayment = TapNGoPayment(appId, apiKey, publicKey)
        payment.setSingleAndRecurrentPayment(merTradeNo, totalPrice, PAY_CURRENCY, remark, NOTIFY_URL)
        doPayment(payment)
    }

    private fun doPayment(payment: TapNGoPayment) {
        Logger.d("doPayment, SandboxMode:" + TapNGoSdkSettings.isSandboxModeEnabled())
        try {
            payment.doPayment(
                activityRef.get(),
                IPaymentAuthFailListener { result, message, merTradeNo ->
                    val payResult = TapNGoPayResult(result, merTradeNo, message)
                    this.onPaymentFail(payResult)
                })
        } catch (var4: DoPaymentException) {
            Logger.d("TapNGoPaymentActivity, doPayment error:" + var4.message)
            val result: TapNGoPayResult = when (var4.message) {
                "You should payment for TapNGoPayment Object before call doPayment" -> {
                    TapNGoPayResult("SS500", activityRef.get()?.application)
                }

                "Cannot find Wallet on this device, or the installed Wallet do not support this SDK version" -> {
                    TapNGoPayResult("SS200", activityRef.get()?.application)
                }

                "PayStatement info not valid" -> {
                    TapNGoPayResult(
                        this.getPayStateInvalidResultCode(var4.payStateValidationResult),
                        activityRef.get()?.application
                    )
                }

                else -> {
                    TapNGoPayResult("SS999", activityRef.get()?.application)
                }
            }
            Logger.d("onPaymentFail, result code:" + result.resultCode)
            this.onPaymentFail(result)
        }
    }

    private fun getPayStateInvalidResultCode(payStateValidationResult: PayStateValidationResult): String? {
        return when (payStateValidationResult) {
            PayStateValidationResult.INVALID_APP_ID -> "SS100"
            PayStateValidationResult.INVALID_API_KEY -> "SS101"
            PayStateValidationResult.INVALID_PUBLIC_KEY -> "SS102"
            PayStateValidationResult.INVALID_MERTRADE_NO -> "SS103"
            PayStateValidationResult.INVALID_PAYMENT_TYPE -> "SS107"
            PayStateValidationResult.INVALID_EXTRA -> "SS108"
            PayStateValidationResult.INVALID_REMARK -> "SS106"
            PayStateValidationResult.INVALID_TOTAL_PRICE -> "SS104"
            PayStateValidationResult.INVALID_CURRENCY -> "SS105"
            PayStateValidationResult.INVALID_NOTIFYURL -> "SS109"
            else -> "SS999"
        }
    }

    fun getSdkVersion(): String {
        return TapNGoSdkSettings.getSdkVersion()
    }

    fun setSandboxMode(enable: Boolean) {
        TapNGoSdkSettings.setSandboxMode(enable)
    }

    @OptIn(DelicateCoroutinesApi::class)
    fun onPaymentSuccess(result: TapNGoPayResult) {
        GlobalScope.launch(Dispatchers.Main) {
            channel.invokeMethod("paymentSuccessWithPayResult", HashMap<String, Any>().apply {
                put("resultCode", result.resultCode)
                put("merTradeNo", result.merTradeNo)
                put("recurrentToken", result.recurrentToken)
                put("message", result.message)
                put("tradeNo", result.tradeNo)
                put("tradeStatus", result.tradeStatus?.name ?: "")
            })
        }
    }

    @OptIn(DelicateCoroutinesApi::class)
    fun onPaymentFail(result: TapNGoPayResult) {
        GlobalScope.launch(Dispatchers.Main) {
            channel.invokeMethod("paymentFailWithPayResult", HashMap<String, Any>().apply {
                put("resultCode", result.resultCode)
                put("merTradeNo", result.merTradeNo)
                put("recurrentToken", result.recurrentToken)
                put("message", result.message)
                put("tradeNo", result.tradeNo)
                put("tradeStatus", result.tradeStatus?.name ?: "")
            })
        }
    }
}