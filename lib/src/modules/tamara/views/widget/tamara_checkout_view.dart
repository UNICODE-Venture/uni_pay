import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:uni_pay/src/modules/tamara/core/models/tamara_callback.dart';
import 'package:uni_pay/src/views/design_system.dart';
import 'package:uni_pay/uni_pay.dart';

import '../../../../core/keys/api_keys.dart';
import '../../../../utils/utils.dart';
import '../../core/models/tamara_urls.dart';

class TamaraCheckoutView extends StatefulWidget {
  ///* Contains the checkout url and the success, failed and cancel callbacks
  final TamaraUrls tamaraUrls;
  final ValueChanged<TamaraCallBackResponse> onPaymentSuccess;
  final VoidCallback onPaymentFailed;
  final VoidCallback onPaymentCanceled;
  const TamaraCheckoutView(
      {Key? key,
      required this.tamaraUrls,
      required this.onPaymentSuccess,
      required this.onPaymentFailed,
      required this.onPaymentCanceled})
      : super(key: key);

  @override
  State<TamaraCheckoutView> createState() => _TamaraCheckoutViewState();
}

class _TamaraCheckoutViewState extends State<TamaraCheckoutView> {
  final _viewKey = GlobalKey();
  late InAppWebViewController inAppViewController;

  @override
  Widget build(BuildContext context) {
    final tamaraUrls = widget.tamaraUrls;
    return Scaffold(
      body: Stack(
        children: [
          InAppWebView(
            key: _viewKey,
            initialSettings: ApiKeys.webViewGroupOptions,
            initialUrlRequest: URLRequest(url: WebUri(tamaraUrls.checkoutUrl)),
            shouldOverrideUrlLoading: (controller, action) async {
              inAppViewController = controller;
              String? currentLoadedUrl = action.request.url?.toString();
              uniLog("Url: $currentLoadedUrl");
              NavigationActionPolicy actionPolicy =
                  NavigationActionPolicy.ALLOW;
              if (currentLoadedUrl != null) {
                //* Success
                if (currentLoadedUrl.startsWith(tamaraUrls.successUrl)) {
                  actionPolicy = NavigationActionPolicy.CANCEL;
                  TamaraCallBackResponse tamaraCallBackResponse =
                      TamaraCallBackResponse.fromMap(
                          action.request.url!.queryParameters);
                  if (tamaraUrls.authoriseOrder) {
                    TamaraCallBackResponse response =
                        await UniTamara.authoriseAndCaptureTamaraOrder(
                            tamaraCallBackResponse: tamaraCallBackResponse,
                            captureOrder: tamaraUrls.captureOrder);

                    if (response.paymentStatus.isSuccess) {
                      widget.onPaymentSuccess.call(response);
                    } else {
                      widget.onPaymentFailed.call();
                    }
                  } else {
                    widget.onPaymentSuccess.call(tamaraCallBackResponse);
                  }
                }
                //* Failed
                else if (currentLoadedUrl.startsWith(tamaraUrls.failedUrl)) {
                  actionPolicy = NavigationActionPolicy.CANCEL;
                  widget.onPaymentFailed.call();
                }
                //* Cancelled
                else if (currentLoadedUrl.startsWith(tamaraUrls.cancelUrl)) {
                  actionPolicy = NavigationActionPolicy.CANCEL;
                  widget.onPaymentCanceled.call();
                }
              }
              return actionPolicy;
            },
            onProgressChanged: (controller, progress) {
              if (progress == 100) {
                UniTamara.currentStateNotifier.value =
                    UniPayCurrentState.success;
              }
            },
          ),
          ValueListenableBuilder(
            valueListenable: UniTamara.currentStateNotifier,
            builder: (_, state, ___) => Visibility(
                visible: state.isLoading,
                child: UniPayDesignSystem.loadingIndicator()),
          ),
        ],
      ),
    );
  }
}
