import 'package:flutter/material.dart';

class MyMessageHandler {
  ///===for showing customScaffoldMessenger everywhere===///
  static void showMySnackBar(
      {required var scaffoldkey, required String customMessage}) {
    scaffoldkey.currentState!.showSnackBar(SnackBar(
            backgroundColor: Colors.transparent,
            //  width: double.infinity,
            elevation: 0,
            content: Container(
              height: 80,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                // color: Colors.grey.shade300,
                gradient: LinearGradient(
                    colors: [
                      Colors.teal.shade100,
                      Colors.teal.shade300,
                      Colors.teal.shade700
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: const [0.3, 0.6, 0.9]),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade500,
                      offset: const Offset(-4, -4)),
                ],
              ),
              child: Text(
                customMessage,
                style: const TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 25,
                    fontWeight: FontWeight.w400),
              ),
            ))

        //
        );
  }
}
