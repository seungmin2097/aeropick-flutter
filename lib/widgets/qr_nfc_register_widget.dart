import 'package:flutter/material.dart';
import '../theme/aerok_colors.dart';
import '../screens/qr_scan_screen.dart';

class QrNfcRegisterWidget extends StatelessWidget {
  const QrNfcRegisterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const QrScanScreen(),
          ),
        );
      },
      child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AeroKColors.yellow.withOpacity(0.1),
            AeroKColors.lightYellow.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AeroKColors.yellow.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: AeroKColors.yellow.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AeroKColors.yellow.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.qr_code_scanner, color: AeroKColors.yellow),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'QR/NFC 스캔으로 굿즈 등록 (데모)',
              style: TextStyle(
                color: AeroKColors.darkNavy,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const Icon(Icons.chevron_right, color: AeroKColors.darkGray),
        ],
      ),
      ),
    );
  }
}


