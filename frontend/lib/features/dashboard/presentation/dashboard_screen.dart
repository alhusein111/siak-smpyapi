import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../auth/providers/auth_provider.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  final Color navyPrimary = const Color(0xFF00254A);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (ref.read(authProvider).userName == null) {
        final isLoggedIn = await ref.read(authProvider.notifier).checkAuth();
        if (!mounted) return;
        if (!isLoggedIn) context.go('/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth > 900;

        return Scaffold(
          backgroundColor: Colors.grey.shade100,
          drawer: isDesktop ? null : Drawer(child: _buildSidebar()),
          body: Row(
            children: [
              if (isDesktop) SizedBox(width: 260, child: _buildSidebar()),
              Expanded(
                child: Column(
                  children: [
                    _buildTopHeader(isDesktop, authState.userName ?? "Pengguna"),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(24.0),
                        child: _buildMainContent(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // === KOMPONEN SIDEBAR ===
  Widget _buildSidebar() {
    // FIX 1: Mengganti Container menjadi Material agar ListTile tidak error
    return Material(
      color: navyPrimary,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 32, 20, 20),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    // FIX 3: Pastikan nama dan ekstensi sama persis dengan file di folder
                    'assets/images/logo_baru.png', 
                    height: 40,
                    width: 40,
                    fit: BoxFit.cover,
                    errorBuilder: (c, e, s) => const Icon(Icons.school, color: Colors.amber, size: 40),
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('SIAK-SMPYAPI', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                      Text('SMP YAPI AL-HUSAENI', style: TextStyle(color: Colors.white70, fontSize: 10)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(color: Colors.white24, height: 1),
          
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 16),
              children: [
                _sidebarCategory('UTAMA'),
                _sidebarItem(Icons.dashboard_outlined, 'Ringkasan / Beranda', isActive: true),
                const SizedBox(height: 16),
                _sidebarCategory('AKADEMIK & SISWA'),
                _sidebarItem(Icons.people_alt_outlined, 'Data Siswa'),
                _sidebarItem(Icons.calendar_month_outlined, 'Jadwal Pelajaran'),
                _sidebarItem(Icons.assessment_outlined, 'Nilai & Rapor'),
                _sidebarItem(Icons.check_circle_outline, 'Kehadiran Siswa'),
                const SizedBox(height: 16),
                _sidebarCategory('KEUANGAN & SPP'),
                _sidebarItem(Icons.receipt_long_outlined, 'Tagihan SPP'),
                _sidebarItem(Icons.point_of_sale_outlined, 'Pembayaran Kasir'),
              ],
            ),
          ),
          
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(border: Border(top: BorderSide(color: Colors.white24))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Status Server', style: TextStyle(color: Colors.white54, fontSize: 12)),
                Row(
                  children: [
                    Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.greenAccent, shape: BoxShape.circle)),
                    const SizedBox(width: 6),
                    const Text('Terhubung', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _sidebarCategory(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Text(
        title,
        style: const TextStyle(color: Colors.white54, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.2),
      ),
    );
  }

  Widget _sidebarItem(IconData icon, String title, {bool isActive = false}) {
    return ListTile(
      leading: Icon(icon, color: isActive ? Colors.white : Colors.white70, size: 20),
      title: Text(title, style: TextStyle(color: isActive ? Colors.white : Colors.white70, fontSize: 14, fontWeight: isActive ? FontWeight.bold : FontWeight.normal)),
      tileColor: isActive ? Colors.white.withOpacity(0.1) : null,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24),
      onTap: () {}, 
    );
  }

  // === KOMPONEN TOP HEADER ===
  Widget _buildTopHeader(bool isDesktop, String userName) {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        children: [
          if (!isDesktop) ...[
            // FIX 2: Bungkus dengan Builder agar Scaffold.of() menemukan context yang benar
            Builder(
              builder: (ctx) => IconButton(
                icon: const Icon(Icons.menu, color: Colors.black87),
                onPressed: () => Scaffold.of(ctx).openDrawer(),
              ),
            ),
            const SizedBox(width: 8),
          ],
          
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(6)),
            child: const Row(
              children: [
                Icon(Icons.calendar_today, size: 14, color: Colors.blue),
                SizedBox(width: 8),
                Text('T.A. 2024/2025 Genap', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.blue)),
              ],
            ),
          ),
          
          const Spacer(),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(userName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const Text('Staf Tata Usaha', style: TextStyle(fontSize: 11, color: Colors.grey)),
            ],
          ),
          const SizedBox(width: 16),
          InkWell(
            onTap: () {
              ref.read(authProvider.notifier).logout();
              context.go('/login');
            },
            child: CircleAvatar(
              backgroundColor: navyPrimary,
              child: const Icon(Icons.person, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }

  // === KONTEN TENGAH ===
  Widget _buildMainContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(color: navyPrimary, borderRadius: BorderRadius.circular(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(4)),
                    child: const Text('FLUTTER & WEB SPECIFICATION', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text('SIAK-SMPYAPI Dashboard', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text(
                'Selamat datang di Sistem Informasi Akademik Terpadu SMP YAPI Al-Husaeni.\nPilih menu di panel kiri untuk mengelola data operasional sekolah.',
                style: TextStyle(color: Colors.white70, fontSize: 14, height: 1.5),
              ),
            ],
          ),
        ),
      ],
    );
  }
}