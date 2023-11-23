package com.example.sunmi_printers

import PrinterStatus
import SunmiPrinterApi
import com.sunmi.peripheral.printer.InnerPrinterCallback
import com.sunmi.peripheral.printer.InnerPrinterManager
import com.sunmi.peripheral.printer.SunmiPrinterService
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodChannel

/** SunmiPrintersPlugin */
class SunmiPrintersPlugin : FlutterPlugin, SunmiPrinterApi {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private var printerService: SunmiPrinterService? = null

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

    override fun getPrinterStatus(): PrinterStatus {
        return when (printerService?.updatePrinterState()) {
            1 -> PrinterStatus.NORMAL
            else -> PrinterStatus.UNKNOWN
        }
    }
}
