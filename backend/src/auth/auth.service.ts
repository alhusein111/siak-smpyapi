import { Injectable, UnauthorizedException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { JwtService } from '@nestjs/jwt'; // <--- Tambahkan ini
import * as bcrypt from 'bcrypt';

@Injectable()
export class AuthService {
  // Tambahkan jwtService ke dalam constructor
  constructor(
    private prisma: PrismaService,
    private jwtService: JwtService // <--- Tambahkan ini
  ) {}

  async register(data: any) {
    const hashedPassword = await bcrypt.hash(data.password, 10);
    const user = await this.prisma.user.create({
      data: {
        email: data.email,
        password: hashedPassword,
        name: data.name,
        role: data.role || 'GURU',
      },
    });
    return { message: 'User berhasil dibuat!', user };
  }

  async login(data: any) {
    const user = await this.prisma.user.findUnique({ where: { email: data.email } });
    if (!user) {
      throw new UnauthorizedException('Email tidak ditemukan');
    }

    const isPasswordValid = await bcrypt.compare(data.password, user.password);
    if (!isPasswordValid) {
      throw new UnauthorizedException('Password salah');
    }

    // === BAGIAN BARU: MEMBUAT TIKET (JWT) ===
    // Data apa saja yang mau kita "tulis" di dalam tiket tersebut
    const payload = { sub: user.id, email: user.email, role: user.role };
    
    // Cetak tiketnya
    const token = await this.jwtService.signAsync(payload);

    // Kembalikan pesan dan tiketnya (access_token) ke Flutter
    return { 
      message: 'Login sukses!', 
      access_token: token, // <--- Tiket dikirim di sini
      user: { id: user.id, name: user.name, role: user.role } // Jangan pernah mengirim password kembali!
    };
  }
}