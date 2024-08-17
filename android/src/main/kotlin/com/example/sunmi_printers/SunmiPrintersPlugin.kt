package com.example.sunmi_printers

import SunmiPrinterApi
import TransBean
import android.graphics.BitmapFactory
import android.util.Log
import com.sunmi.peripheral.printer.InnerPrinterCallback
import com.sunmi.peripheral.printer.InnerPrinterManager
import com.sunmi.peripheral.printer.InnerResultCallback
import com.sunmi.peripheral.printer.SunmiPrinterService
import io.flutter.embedding.engine.plugins.FlutterPlugin
import com.sunmi.peripheral.printer.TransBean as SunmiTransbean

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

    override fun printColumnsText(
        columns: List<String>,
        colsWidth: List<Long>,
        colsAlign: List<Long>,
    ) {
        val textArray = columns.toTypedArray()
        val widthArray = colsWidth.map { it.toInt() }.toIntArray()
        val alignArray = colsAlign.map { it.toInt() }.toIntArray()

        printerService?.printColumnsText(textArray, widthArray, alignArray, resultCallback)
    }

    override fun printColumnsString(
        columns: List<String>,
        colsWidth: List<Long>,
        colsAlign: List<Long>,
    ) {
        val textArray = columns.toTypedArray()
        val widthArray = colsWidth.map { it.toInt() }.toIntArray()
        val alignArray = colsAlign.map { it.toInt() }.toIntArray()

        printerService?.printColumnsString(textArray, widthArray, alignArray, resultCallback)
    }

    override fun printBitmap(image: ByteArray) {
        val bitmap = BitmapFactory.decodeByteArray(image, 0, image.size)

        printerService?.printBitmap(bitmap, resultCallback)
    }

    override fun printBitmapCustom(image: ByteArray, type: Long) {
        val bitmap = BitmapFactory.decodeByteArray(image, 0, image.size)

        printerService?.printBitmapCustom(bitmap, type.toInt(), resultCallback)
    }

    override fun printBarCode(
        data: String,
        symbology: Long,
        height: Long,
        width: Long,
        textPosition: Long,
    ) {
        printerService?.printBarCode(
            data,
            symbology.toInt(),
            height.toInt(),
            width.toInt(),
            textPosition.toInt(),
            resultCallback
        )
    }

    override fun printQrCode(data: String, moduleSize: Long, errorLevel: Long) {
        printerService?.printQRCode(data, moduleSize.toInt(), errorLevel.toInt(), resultCallback)
    }

    override fun print2DCode(data: String, symbology: Long, moduleSize: Long, errorLevel: Long) {
        printerService?.print2DCode(
            data,
            symbology.toInt(),
            moduleSize.toInt(),
            errorLevel.toInt(),
            resultCallback
        )
    }

    override fun commitPrint(transBean: List<TransBean>) {
        val parsed = transBean.map {
            SunmiTransbean(
                it.type!!.toByte(), it.text, it.data,
            )
        }
        printerService?.commitPrint(parsed.toTypedArray(), resultCallback)
    }

    override fun enterPrinterBuffer(clean: Boolean) {
        printerService?.enterPrinterBuffer(clean)
    }

    override fun exitPrinterBuffer(commit: Boolean) {
        printerService?.exitPrinterBuffer(commit)
    }

    override fun commitPrinterBuffer() {
        printerService?.commitPrinterBuffer()
    }

    override fun lineWrap(lines: Long) {
        printerService?.lineWrap(lines.toInt(), resultCallback)
    }

}
