import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrDisplayDialog extends StatelessWidget {
  final String qrData;
  final String title;
  final String buttonText;
  final VoidCallback? onClose;

  const QrDisplayDialog({
    Key? key,
    required this.qrData,
    this.title = "Покажите QR Контролеру",
    this.buttonText = "Закрыть",
    this.onClose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 17,
                color: Colors.black
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            QrImageView(
              data: qrData,
              size: 200,
              backgroundColor: Colors.white,
            ),
            const SizedBox(height: 28),
            SizedBox(
              width: 140,
              height: 42,
              child: OutlinedButton(
                onPressed: onClose ?? () => Navigator.of(context).pop(),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF166CFF),
                  side: const BorderSide(color: Color(0xFF166CFF)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                child: Text(buttonText),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
