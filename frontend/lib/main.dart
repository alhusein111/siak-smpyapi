import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Tambahkan baris ini
import 'app/router.dart'; // Memanggil file router yang baru kita buat

void main() {
  // Bungkus SiakApp dengan ProviderScope
  runApp(
    const ProviderScope(
      child: SiakApp(),
    ),
  );
}

class SiakApp extends StatelessWidget {
  const SiakApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Perhatikan: Kita mengubah MaterialApp menjadi MaterialApp.router
    return MaterialApp.router(
      title: 'SIAK SMP YAPI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade800),
        useMaterial3: true,
      ),
      // Menyambungkan konfigurasi router ke aplikasi
      routerConfig: appRouter, 
    );
  }
}