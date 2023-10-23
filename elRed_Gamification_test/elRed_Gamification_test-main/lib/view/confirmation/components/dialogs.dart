import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';

class FailedDialog extends StatelessWidget {
  final String? message;
  const FailedDialog({super.key, this.message});
  void callDialog(BuildContext context) {
    showDialog(context: context, builder: (context) => this);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Failed !", style: context.textTheme.headlineSmall),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        message ?? '',
                        style: context.textTheme.titleLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 12,
              right: 12,
              child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({super.key});
  void callDialog(BuildContext context) {
    showDialog(context: context, builder: (context) => this);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Center(
                child: Text(
                  "Success 🎉",
                  style: context.textTheme.headlineLarge,
                ),
              ),
            ),
            Positioned(
              top: 12,
              right: 12,
              child: IconButton(
                icon: const Icon(
                  Icons.close,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key});
  void callDialog(BuildContext context) {
    showDialog(context: context, builder: (context) => this);
  }

  @override
  Widget build(BuildContext context) {
    return const Dialog(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [Padding(
          padding: EdgeInsets.all(22.0),
          child: CircularProgressIndicator(),
        )],
      ),
    );
  }
}
