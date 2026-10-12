import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/auth_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  bool _isObscure = true;
  bool _rememberMe = true;

  final Color primaryNavy = const Color(0xFF173B65);
  final Color primaryBlue = const Color(0xFF2458C5);
  final Color surfaceBg = const Color(0xFFF4F7FB);
  final Color borderStr = const Color(0xFFDCE4EF);

  Future<void> _prosesLogin() async {
    final errorMessage = await ref.read(authProvider.notifier).login(
      _emailController.text,
      _passwordController.text,
    );

    if (!mounted) return;

    if (errorMessage == null) {
      context.go('/dashboard');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: const Color(0xFFC83C45),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authProvider).isLoading;
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 850;

    return Scaffold(
      backgroundColor: surfaceBg,
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(isDesktop ? 40.0 : 20.0),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 1000),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: primaryNavy.withOpacity(0.08),
                  blurRadius: 24,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // --- PANEL KIRI (NAVY) ---
                  if (isDesktop)
                    Expanded(
                      flex: 5,
                      child: Container(
                        color: primaryNavy,
                        padding: const EdgeInsets.all(40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Image.asset(
                                    'assets/images/logo_baru.png',
                                    height: 48,
                                    width: 48,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('SMP YAPI', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                                    Text('Al-Husaeni Lebakbiru', style: TextStyle(color: Colors.white70, fontSize: 13)),
                                  ],
                                )
                              ],
                            ),
                            // const SizedBox(height: 48),
                            // _buildInfoCard(
                            //   title: 'Status Server Utama',
                            //   subtitle: 'Database Dapodik Terintegrasi',
                            //   meta: 'Latensi: 14ms • Enkripsi TLS 1.3',
                            //   badge: 'Normal',
                            //   badgeColor: const Color(0xFF16815D),
                            // ),
                            const SizedBox(height: 16),
                            _buildInfoCard(
                              title: 'Tahun Akademik Berjalan',
                              subtitle: '2024 / 2025 Genap',
                              meta: 'Minggu Efektif KBM: Ke-8',
                              badge: 'Normal',
                              badgeColor: const Color(0xFF16815D),
                            ),
                            const Spacer(),
                            const Divider(color: Colors.white24),
                            const SizedBox(height: 16),
                            const Row(
                              children: [
                                Icon(Icons.verified_user_outlined, color: Color(0xFFF2B84B), size: 20),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    'Sistem ini dilindungi hak akses berlapis. Hubungi TU jika terdapat kendala verifikasi.',
                                    style: TextStyle(color: Colors.white70, fontSize: 12, height: 1.5),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),

                  // --- PANEL KANAN (FORM LOGIN) ---
                  Expanded(
                    flex: 7,
                    child: Padding(
                      padding: EdgeInsets.all(isDesktop ? 48.0 : 32.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (!isDesktop) ...[
                            Center(child: Image.asset('assets/images/logo_baru.png', height: 64)),
                            const SizedBox(height: 24),
                          ],
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    isDesktop ? 'Masuk ke SIAK' : 'Masuk SIAK Mobile',
                                    style: TextStyle(fontSize: isDesktop ? 28 : 24, fontWeight: FontWeight.bold, color: primaryNavy),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    isDesktop ? 'Gunakan akun resmi institusi yang telah terdaftar' : 'SIAK-SMPYAPI Al-Husaeni',
                                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                                  ),
                                ],
                              ),
                              if (isDesktop)
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(color: const Color(0xFFEDF2F8), borderRadius: BorderRadius.circular(12)),
                                  child: Icon(Icons.key, color: primaryBlue),
                                ),
                            ],
                          ),
                          const SizedBox(height: 32),

                          // Field Username / Email
                          const Text('Username / NIP / NISN', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _emailController,
                            decoration: _inputStyle(Icons.person_outline).copyWith(
                              hintText: 'Masukkan kredensial',
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Field Password
                          const Text('Kata Sandi', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: _isObscure,
                            decoration: _inputStyle(Icons.lock_outline).copyWith(
                              hintText: 'Masukkan kata sandi',
                              suffixIcon: IconButton(
                                icon: Icon(_isObscure ? Icons.visibility_outlined : Icons.visibility_off_outlined, color: Colors.grey),
                                onPressed: () => setState(() => _isObscure = !_isObscure),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Remember Me & Forgot Password
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: Checkbox(
                                      value: _rememberMe,
                                      activeColor: primaryBlue,
                                      onChanged: (val) => setState(() => _rememberMe = val!),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Text('Ingat identitas', style: TextStyle(fontSize: 13, color: Colors.black87)),
                                ],
                              ),
                              Text('Lupa Sandi?', style: TextStyle(fontSize: 13, color: Colors.grey.shade600)),
                            ],
                          ),
                          const SizedBox(height: 32),

                          // Tombol Login
                          ElevatedButton(
                            onPressed: isLoading ? null : _prosesLogin,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryBlue,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              elevation: 0,
                              minimumSize: const Size(double.infinity, 56),
                            ),
                            child: isLoading
                                ? const SizedBox(height: 24, width: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(isDesktop ? 'Masuk ke SIAK' : 'Masuk (Mobile)', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                      if (isDesktop) ...[
                                        const SizedBox(width: 8),
                                        const Icon(Icons.arrow_forward, size: 20),
                                      ]
                                    ],
                                  ),
                          ),
                          const SizedBox(height: 32),

                          // Footer Info
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(color: const Color(0xFFEDF2F8), borderRadius: BorderRadius.circular(12)),
                            child: Row(
                              children: [
                                Icon(Icons.info_outline, color: primaryNavy, size: 20),
                                const SizedBox(width: 12),
                                const Expanded(
                                  child: Text(
                                    'Aplikasi internal terenkripsi. Hubungi Bagian Administrasi/TU untuk kendala akses.',
                                    style: TextStyle(fontSize: 12, color: Colors.black87),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputStyle(IconData icon) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      prefixIcon: Icon(icon, color: Colors.grey.shade600, size: 22),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: borderStr, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: primaryBlue, width: 1.5),
      ),
    );
  }

  Widget _buildInfoCard({required String title, required String subtitle, required String meta, String? badge, Color? badgeColor}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(color: Colors.white70, fontSize: 12)),
              if (badge != null)
                Row(
                  children: [
                    Container(width: 6, height: 6, decoration: BoxDecoration(color: badgeColor, shape: BoxShape.circle)),
                    const SizedBox(width: 6),
                    Text(badge, style: TextStyle(color: badgeColor, fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                )
            ],
          ),
          const SizedBox(height: 8),
          Text(subtitle, style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Text(meta, style: const TextStyle(color: Colors.white54, fontSize: 12)),
        ],
      ),
    );
  }
}