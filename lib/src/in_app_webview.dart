import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/gestures.dart';

import 'context_menu.dart';
import 'webview.dart';
import 'types.dart';
import 'in_app_webview_controller.dart';

///Flutter Widget for adding an **inline native WebView** integrated in the flutter widget tree.
class InAppWebView extends StatefulWidget implements WebView {
  /// `gestureRecognizers` specifies which gestures should be consumed by the WebView.
  /// It is possible for other gesture recognizers to be competing with the web view on pointer
  /// events, e.g if the web view is inside a [ListView] the [ListView] will want to handle
  /// vertical drags. The web view will claim gestures that are recognized by any of the
  /// recognizers on this list.
  /// When `gestureRecognizers` is empty or null, the web view will only handle pointer events for gestures that
  /// were not claimed by any other gesture recognizer.
  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers;

  ///The window id of a [CreateWindowRequest.windowId].
  final int windowId;

  const InAppWebView({
    Key key,
    this.windowId,
    this.initialUrl = "about:blank",
    this.initialFile,
    this.initialData,
    this.initialHeaders = const {},
    this.initialOptions,
    this.contextMenu,
    this.onWebViewCreated,
    this.onLoadStart,
    this.onLoadStop,
    this.onLoadError,
    this.onLoadHttpError,
    this.onConsoleMessage,
    this.onProgressChanged,
    this.shouldOverrideUrlLoading,
    this.onLoadResource,
    this.onScrollChanged,
    this.onDownloadStart,
    this.onLoadResourceCustomScheme,
    this.onCreateWindow,
    this.onCloseWindow,
    this.onJsAlert,
    this.onJsConfirm,
    this.onJsPrompt,
    this.onReceivedHttpAuthRequest,
    this.onReceivedServerTrustAuthRequest,
    this.onReceivedClientCertRequest,
    this.onFindResultReceived,
    this.shouldInterceptAjaxRequest,
    this.onAjaxReadyStateChange,
    this.onAjaxProgress,
    this.shouldInterceptFetchRequest,
    this.onUpdateVisitedHistory,
    this.onPrint,
    this.onLongPressHitTestResult,
    this.onEnterFullscreen,
    this.onExitFullscreen,
    this.onPageCommitVisible,
    this.onTitleChanged,
    this.onWindowFocus,
    this.onWindowBlur,
    this.androidOnSafeBrowsingHit,
    this.androidOnPermissionRequest,
    this.androidOnGeolocationPermissionsShowPrompt,
    this.androidOnGeolocationPermissionsHidePrompt,
    this.androidShouldInterceptRequest,
    this.androidOnRenderProcessGone,
    this.androidOnRenderProcessResponsive,
    this.androidOnRenderProcessUnresponsive,
    this.androidOnFormResubmission,
    this.androidOnScaleChanged,
    this.androidOnRequestFocus,
    this.androidOnReceivedIcon,
    this.androidOnReceivedTouchIconUrl,
    this.androidOnJsBeforeUnload,
    this.androidOnReceivedLoginRequest,
    this.iosOnWebContentProcessDidTerminate,
    this.iosOnDidReceiveServerRedirectForProvisionalNavigation,
    this.gestureRecognizers,
  }) : super(key: key);

  @override
  _InAppWebViewState createState() => _InAppWebViewState();

  @override
  final void Function(InAppWebViewController controller)
      androidOnGeolocationPermissionsHidePrompt;

  @override
  final Future<GeolocationPermissionShowPromptResponse> Function(
          InAppWebViewController controller, String origin)
      androidOnGeolocationPermissionsShowPrompt;

  @override
  final Future<PermissionRequestResponse> Function(
      InAppWebViewController controller,
      String origin,
      List<String> resources) androidOnPermissionRequest;

  @override
  final Future<SafeBrowsingResponse> Function(InAppWebViewController controller,
      String url, SafeBrowsingThreat threatType) androidOnSafeBrowsingHit;

  @override
  final InAppWebViewInitialData initialData;

  @override
  final String initialFile;

  @override
  final Map<String, String> initialHeaders;

  @override
  final InAppWebViewGroupOptions initialOptions;

  @override
  final String initialUrl;

  @override
  final ContextMenu contextMenu;

  @override
  final void Function(InAppWebViewController controller, String url)
      onPageCommitVisible;

  @override
  final void Function(InAppWebViewController controller, String title)
      onTitleChanged;

  @override
  final void Function(InAppWebViewController controller)
      iosOnDidReceiveServerRedirectForProvisionalNavigation;

  @override
  final void Function(InAppWebViewController controller)
      iosOnWebContentProcessDidTerminate;

  @override
  final Future<AjaxRequestAction> Function(
          InAppWebViewController controller, AjaxRequest ajaxRequest)
      onAjaxProgress;

  @override
  final Future<AjaxRequestAction> Function(
          InAppWebViewController controller, AjaxRequest ajaxRequest)
      onAjaxReadyStateChange;

  @override
  final void Function(
          InAppWebViewController controller, ConsoleMessage consoleMessage)
      onConsoleMessage;

  @override
  final Future<bool> Function(InAppWebViewController controller,
      CreateWindowRequest createWindowRequest) onCreateWindow;

  @override
  final void Function(InAppWebViewController controller) onCloseWindow;

  @override
  final void Function(InAppWebViewController controller) onWindowFocus;

  @override
  final void Function(InAppWebViewController controller) onWindowBlur;

  @override
  final void Function(InAppWebViewController controller) androidOnRequestFocus;

  @override
  final void Function(InAppWebViewController controller, Uint8List icon)
      androidOnReceivedIcon;

  @override
  final void Function(
          InAppWebViewController controller, String url, bool precomposed)
      androidOnReceivedTouchIconUrl;

  @override
  final void Function(InAppWebViewController controller, String url)
      onDownloadStart;

  @override
  final void Function(InAppWebViewController controller, int activeMatchOrdinal,
      int numberOfMatches, bool isDoneCounting) onFindResultReceived;

  @override
  final Future<JsAlertResponse> Function(
          InAppWebViewController controller, JsAlertRequest jsAlertRequest)
      onJsAlert;

  @override
  final Future<JsConfirmResponse> Function(
          InAppWebViewController controller, JsConfirmRequest jsConfirmRequest)
      onJsConfirm;

  @override
  final Future<JsPromptResponse> Function(
          InAppWebViewController controller, JsPromptRequest jsPromptRequest)
      onJsPrompt;

  @override
  final void Function(InAppWebViewController controller, String url, int code,
      String message) onLoadError;

  @override
  final void Function(InAppWebViewController controller, String url,
      int statusCode, String description) onLoadHttpError;

  @override
  final void Function(
          InAppWebViewController controller, LoadedResource resource)
      onLoadResource;

  @override
  final Future<CustomSchemeResponse> Function(
          InAppWebViewController controller, String scheme, String url)
      onLoadResourceCustomScheme;

  @override
  final void Function(InAppWebViewController controller, String url)
      onLoadStart;

  @override
  final void Function(InAppWebViewController controller, String url) onLoadStop;

  @override
  final void Function(InAppWebViewController controller,
      InAppWebViewHitTestResult hitTestResult) onLongPressHitTestResult;

  @override
  final void Function(InAppWebViewController controller, String url) onPrint;

  @override
  final void Function(InAppWebViewController controller, int progress)
      onProgressChanged;

  @override
  final Future<ClientCertResponse> Function(
          InAppWebViewController controller, ClientCertChallenge challenge)
      onReceivedClientCertRequest;

  @override
  final Future<HttpAuthResponse> Function(
          InAppWebViewController controller, HttpAuthChallenge challenge)
      onReceivedHttpAuthRequest;

  @override
  final Future<ServerTrustAuthResponse> Function(
          InAppWebViewController controller, ServerTrustChallenge challenge)
      onReceivedServerTrustAuthRequest;

  @override
  final void Function(InAppWebViewController controller, int x, int y)
      onScrollChanged;

  @override
  final void Function(
          InAppWebViewController controller, String url, bool androidIsReload)
      onUpdateVisitedHistory;

  @override
  final void Function(InAppWebViewController controller) onWebViewCreated;

  @override
  final Future<AjaxRequest> Function(
          InAppWebViewController controller, AjaxRequest ajaxRequest)
      shouldInterceptAjaxRequest;

  @override
  final Future<FetchRequest> Function(
          InAppWebViewController controller, FetchRequest fetchRequest)
      shouldInterceptFetchRequest;

  @override
  final Future<ShouldOverrideUrlLoadingAction> Function(
          InAppWebViewController controller,
          ShouldOverrideUrlLoadingRequest shouldOverrideUrlLoadingRequest)
      shouldOverrideUrlLoading;

  @override
  final void Function(InAppWebViewController controller) onEnterFullscreen;

  @override
  final void Function(InAppWebViewController controller) onExitFullscreen;

  @override
  final Future<WebResourceResponse> Function(
          InAppWebViewController controller, WebResourceRequest request)
      androidShouldInterceptRequest;

  @override
  final Future<WebViewRenderProcessAction> Function(
          InAppWebViewController controller, String url)
      androidOnRenderProcessUnresponsive;

  @override
  final Future<WebViewRenderProcessAction> Function(
          InAppWebViewController controller, String url)
      androidOnRenderProcessResponsive;

  @override
  final void Function(
          InAppWebViewController controller, RenderProcessGoneDetail detail)
      androidOnRenderProcessGone;

  @override
  final Future<FormResubmissionAction> Function(
      InAppWebViewController controller, String url) androidOnFormResubmission;

  @override
  final void Function(
          InAppWebViewController controller, double oldScale, double newScale)
      androidOnScaleChanged;

  @override
  final Future<JsBeforeUnloadResponse> Function(
      InAppWebViewController controller,
      JsBeforeUnloadRequest jsBeforeUnloadRequest) androidOnJsBeforeUnload;

  @override
  final void Function(
          InAppWebViewController controller, LoginRequest loginRequest)
      androidOnReceivedLoginRequest;
}

class _InAppWebViewState extends State<InAppWebView> {
  InAppWebViewController _controller;

  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      if (widget.initialOptions?.android?.useHybridComposition ?? false) {
        return PlatformViewLink(
          viewType: 'com.pichillilorenzo/flutter_inappwebview_fork',
          surfaceFactory: (
              BuildContext context,
              PlatformViewController controller,
              ) {
            return AndroidViewSurface(
              controller: controller,
              gestureRecognizers: widget.gestureRecognizers ?? const <Factory<OneSequenceGestureRecognizer>>{},
              hitTestBehavior: PlatformViewHitTestBehavior.opaque,
            );
          },
          onCreatePlatformView: (PlatformViewCreationParams params) {
            return PlatformViewsService.initSurfaceAndroidView(
              id: params.id,
              viewType: 'com.pichillilorenzo/flutter_inappwebview_fork',
              layoutDirection: TextDirection.rtl,
              creationParams: <String, dynamic>{
                'initialUrl': '${Uri.parse(widget.initialUrl)}',
                'initialFile': widget.initialFile,
                'initialData': widget.initialData?.toMap(),
                'initialHeaders': widget.initialHeaders,
                'initialOptions': widget.initialOptions?.toMap() ?? {},
                'contextMenu': widget.contextMenu?.toMap() ?? {},
                'windowId': widget.windowId
              },
              creationParamsCodec: const StandardMessageCodec(),
            )
              ..addOnPlatformViewCreatedListener(params.onPlatformViewCreated)
              ..addOnPlatformViewCreatedListener((id) => _onPlatformViewCreated(id))
              ..create();
          },
        );
      } else {
        return AndroidView(
          viewType: 'com.pichillilorenzo/flutter_inappwebview_fork',
          onPlatformViewCreated: _onPlatformViewCreated,
          gestureRecognizers: widget.gestureRecognizers,
          layoutDirection: TextDirection.rtl,
          creationParams: <String, dynamic>{
            'initialUrl': '${Uri.parse(widget.initialUrl)}',
            'initialFile': widget.initialFile,
            'initialData': widget.initialData?.toMap(),
            'initialHeaders': widget.initialHeaders,
            'initialOptions': widget.initialOptions?.toMap() ?? {},
            'contextMenu': widget.contextMenu?.toMap() ?? {},
            'windowId': widget.windowId
          },
          creationParamsCodec: const StandardMessageCodec(),
        );
      }
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return UiKitView(
        viewType: 'com.pichillilorenzo/flutter_inappwebview_fork',
        onPlatformViewCreated: _onPlatformViewCreated,
        gestureRecognizers: widget.gestureRecognizers,
        creationParams: <String, dynamic>{
          'initialUrl': '${Uri.parse(widget.initialUrl)}',
          'initialFile': widget.initialFile,
          'initialData': widget.initialData?.toMap(),
          'initialHeaders': widget.initialHeaders,
          'initialOptions': widget.initialOptions?.toMap() ?? {},
          'contextMenu': widget.contextMenu?.toMap() ?? {},
          'windowId': widget.windowId
        },
        creationParamsCodec: const StandardMessageCodec(),
      );
    }
    return Text(
        '$defaultTargetPlatform is not yet supported by the flutter_inappwebview_fork plugin');
  }

  @override
  void didUpdateWidget(InAppWebView oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onPlatformViewCreated(int id) {
    _controller = InAppWebViewController(id, widget);
    if (widget.onWebViewCreated != null) {
      widget.onWebViewCreated(_controller);
    }
  }
}
