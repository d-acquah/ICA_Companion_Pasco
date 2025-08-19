import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ica_companion_pasco/pages/bottom_navigation_page.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;
import 'api_key.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({
    Key? key,
    required this.email,
    required this.reference,
    required this.title,
    required this.uid, // ✅ Firebase UID passed here
  }) : super(key: key);

  final String email;
  final String reference;
  final String title;
  final String uid;

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late final WebViewController _webViewController;
  String? _authorizationUrl;
  bool _isVerifying = false;

  Future<Map<String, dynamic>> _buildTransactionPayload() async {
    const double fixedAmountGhs = 10;
    final int amountInPesewas = (fixedAmountGhs * 100).toInt();
    return {
      "amount": amountInPesewas,
      "email": widget.email,
      "reference": widget.reference,
      "currency": "GHS",
      "metadata": {
        "custom_fields": [
          {
            "display_name": "Firebase UID",
            "variable_name": "firebase_uid",
            "value": widget.uid,
          },
          {
            "display_name": "Payment Platform",
            "variable_name": "platform",
            "value": "Flutter App",
          }
        ],
      }
    };
  }

  Future<String> _initializeTransaction() async {
    final payload = await _buildTransactionPayload();
    debugPrint("📦 Transaction Payload: ${jsonEncode(payload)}");

    const String url = 'https://api.paystack.co/transaction/initialize';
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer ${ApiKey.secretKey}',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(payload),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return responseData['data']['authorization_url'];
    } else {
      throw '❌ Payment initialization failed.\nStatus: ${response.statusCode}\nResponse: ${response.body}';
    }
  }

  Future<bool> _verifyTransaction() async {
    final String url =
        'https://api.paystack.co/transaction/verify/${widget.reference}';
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer ${ApiKey.secretKey}',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      debugPrint("✅ Verification Response: $responseData");
      return responseData['data']['status'] == 'success';
    } else {
      debugPrint("❌ Verification failed: ${response.body}");
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeTransaction().then((url) {
      setState(() {
        _authorizationUrl = url;
      });
      _webViewController = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(
          NavigationDelegate(
            onNavigationRequest: (NavigationRequest request) {
              return NavigationDecision.navigate;
            },
            onWebResourceError: (WebResourceError error) {
              debugPrint("⚠️ WebView error: ${error.description}");
            },
          ),
        )
        ..loadRequest(Uri.parse(url));
    }).catchError((e) {
      debugPrint("🔥 Transaction init error: $e");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const BottomNavigationPage(
            showPaymentSnackBar: true,
            paymentSnackBarMessage: "Payment initialization error.",
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Mobile Money'),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: _authorizationUrl == null
                    ? const Center(child: CircularProgressIndicator())
                    : WebViewWidget(controller: _webViewController),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Center(
                  child: SizedBox(
                    width: 265,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blue,
                        minimumSize: const Size(50, 50),
                        textStyle: const TextStyle(fontSize: 14),
                      ),
                      onPressed: _isVerifying
                          ? null
                          : () async {
                              setState(() {
                                _isVerifying = true;
                              });

                              bool verified = await _verifyTransaction();

                              setState(() {
                                _isVerifying = false;
                              });

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BottomNavigationPage(
                                    showPaymentSnackBar: true,
                                    paymentSnackBarMessage: verified
                                        ? "Payment verified successfully!"
                                        : "Payment failed or not completed. Please try again.",
                                  ),
                                ),
                              );
                            },
                      child: Text(
                        _isVerifying ? 'Verifying...' : 'Verify Transaction',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
