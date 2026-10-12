import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/auth_provider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkSession(); // Jalankan saat layar pertama kali muncul
  }

  Future<void> _checkSession() async {
    await Future.delayed(const Duration(seconds: 1)); // Beri jeda 1 detik agar logo terlihat
    
    final isLoggedIn = await ref.read(authProvider.notifier).checkAuth();
    
    if (!mounted) return;
    
    if (isLoggedIn) {
      context.go('/dashboard'); // Auto-login sukses
    } else {
      context.go('/login'); // Belum login, arahkan ke form
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.school, size: 100, color: Colors.blue),
            SizedBox(height: 24),
            CircularProgressIndicator(), // Animasi loading
          ],
        ),
      ),
    );
  }
}