package com.example.sunmi_printers

import SunmiPrinterApi
import android.util.Log
import com.sunmi.peripheral.printer.InnerPrinterCallback
import com.sunmi.peripheral.printer.InnerPrinterManager
import com.sunmi.peripheral.printer.InnerResultCallback
import com.sunmi.peripheral.printer.SunmiPrinterService
import io.flutter.embedding.engine.plugins.FlutterPlugin

/** SunmiPrintersPlugin */
class SunmiPrintersPlugin : FlutterPlugin, SunmiPrinterApi {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private var printerService: SunmiPrinterService? = null

    private val resultCallback = object : InnerResultCallback() {
        override fun onRunResult(isSuccess: Boolean) {
            Log.d("TAG", "onRunResult: $isSuccess")
        }

        override fun onReturnString(result: String?) {
            Log.d("TAG", "onReturnString: $result")
        }

        override fun onRaiseException(code: Int, msg: String?) {
            Log.d("TAG", "onRaiseException: $code, $msg")
        }

        override fun onPrintResult(code: Int, msg: String?) {
            Log.d("TAG", "onPrintResult: $code, $msg")
        }

    }

    private val callback = object : InnerPrinterCallback() {
        override fun onConnected(service: SunmiPrinterService?) {

            printerService = service

        }

        override fun onDisconnected() {
            printerService = null
        }

    }

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        SunmiPrinterApi.setUp(flutterPluginBinding.binaryMessenger, this)

        InnerPrinterManager.getInstance()
            .bindService(flutterPluginBinding.applicationContext, callback)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        SunmiPrinterApi.setUp(binding.binaryMessenger, null)
    }

    override fun hasPrinter(): Boolean {
        return InnerPrinterManager.getInstance().hasPrinter(printerService)
    }

    override fun getPrinterStatus(): Long? {
        return printerService?.updatePrinterState()?.toLong()
    }

    override fun printerInit() {
        printerService?.printerInit(resultCallback)
    }

    override fun printerSelfChecking() {
        printerService?.printerSelfChecking(resultCallback)
    }

    override fun getPrinterSerialNumber(): String? {
        return printerService?.printerSerialNo
    }

    override fun getPrinterModal(): String? {
        return printerService?.printerModal
    }

    override fun getPrinterVersion(): String? {
        return printerService?.printerVersion
    }

    override fun getServiceVersion(): String? {
        return printerService?.serviceVersion
    }

    override fun getPrintedLength(): Long {
        printerService?.getPrintedLength(resultCallback)
        return 0
    }

    override fun getPrinterPaper(): Long? {
        return printerService?.printerPaper?.toLong()
    }

    override fun printText(text: String) {
        Log.d("TAG", "printText: $text")
        printerService?.printText(text, resultCallback)
    }

    override fun sendRAWData(bytes: ByteArray) {
        printerService?.sendRAWData(bytes, resultCallback)
    }

    override fun setPrinterStyle(key: Long, value: Long) {
        printerService?.setPrinterStyle(key.toInt(), value.toInt())
    }

    override fun getPrinterMode(): Long? {
        return printerService?.printerMode?.toLong()
    }

    override fun getPrinterBBMDistance(): Long? {
        return printerService?.printerBBMDistance?.toLong()
    }

    override fun setAlignment(alignment: Long) {
        printerService?.setAlignment(alignment.toInt(), resultCallback)
    }

}
