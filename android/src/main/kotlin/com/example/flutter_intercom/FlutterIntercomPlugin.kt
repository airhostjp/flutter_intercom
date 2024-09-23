package com.example.flutter_intercom

import android.app.Application

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.intercom.android.sdk.Intercom
import io.intercom.android.sdk.IntercomError
import io.intercom.android.sdk.IntercomSpace
import io.intercom.android.sdk.IntercomStatusCallback
import io.intercom.android.sdk.UserAttributes
import io.intercom.android.sdk.identity.Registration

/** FlutterIntercomPlugin */
class FlutterIntercomPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private var application: Application? = null

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    application = flutterPluginBinding.applicationContext as Application
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_intercom")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when (call.method) {
      "setApiKeyForAppId" -> {
        val args = call.arguments as? Map<*, *>
        val apiKey = args?.get("apiKey") as? String
        val appId = args?.get("appId") as? String

        if (apiKey != null && appId != null) {
          Intercom.initialize(application, apiKey, appId)
          result.success("Success")
        } else {
          result.error("ERROR", "Invalid arguments", null)
        }
      }

      "loginUnidentifiedUser" -> {
        Intercom.client().loginUnidentifiedUser(
          intercomStatusCallback = object : IntercomStatusCallback {
            override fun onSuccess() {
              result.success(
                mapOf(
                  "success" to true,
                  "message" to "Successfully logged in as an unidentified user."
                )
              )
            }

            override fun onFailure(intercomError: IntercomError) {
              result.success(
                mapOf(
                  "success" to false,
                  "message" to intercomError.errorMessage
                )
              )
            }

          }
        )
      }

      "loginUser" -> {
        val args = call.arguments as? Map<*, *>
        val userId = args?.get("userId") as String? ?: ""
        val email = args?.get("email") as String? ?: ""
        val phone = args?.get("phone") as String? ?: ""
        val name = args?.get("name") as String? ?: ""
        val languageOverride = args?.get("languageOverride") as String? ?: ""
        val customAttributes = args?.get("customAttributes") as Map<String, Any>? ?: mapOf()

        val attributes = UserAttributes.Builder()
          .withPhone(phone)
          .withName(name)
          .withLanguageOverride(languageOverride)
          .withCustomAttributes(customAttributes)
          .build()


        val registration = Registration.create().withUserAttributes(attributes)
        if (userId.isNotEmpty()) {
          registration.withUserId(userId)
        }
        if (email.isNotEmpty()) {
          registration.withEmail(email)
        }
        Intercom.client().loginIdentifiedUser(
          userRegistration = registration,
          intercomStatusCallback = object : IntercomStatusCallback{
            override fun onSuccess() {
              mapOf(
                "success" to true,
                "message" to "Successfully logged in."
              )
            }

            override fun onFailure(intercomError: IntercomError) {
              mapOf(
                "success" to false,
                "message" to intercomError.errorMessage
              )
            }

          }
        )
      }

      "present" -> {
        val args = call.arguments as? Map<*, *>
        val space = args?.get("space") as? String

        when (space) {
          "home" -> Intercom.client().present(IntercomSpace.Home)
          "helpCenter" -> Intercom.client().present(IntercomSpace.HelpCenter)
          "messages" -> Intercom.client().present(IntercomSpace.Messages)
          "tickets" -> Intercom.client().present(IntercomSpace.Tickets)
          else -> Intercom.client().present(IntercomSpace.Home)
        }
      }

      "hide" -> {
        Intercom.client().hideIntercom()
      }

      "logout" -> {
        Intercom.client().logout()
      }

      else -> result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
