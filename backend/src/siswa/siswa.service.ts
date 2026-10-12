import { Injectable, ConflictException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service'; // Pastikan path ini sesuai dengan lokasi PrismaService Anda
import { CreateSiswaDto } from './dto/create-siswa.dto';

@Injectable()
export class SiswaService {
  constructor(private prisma: PrismaService) {}

  async create(createSiswaDto: CreateSiswaDto) {
    // 1. Cek apakah NIS atau NISN sudah dipakai oleh siswa lain
    const existingSiswa = await this.prisma.siswa.findFirst({
      where: {
        OR: [
          { nis: createSiswaDto.nis },
          { nisn: createSiswaDto.nisn },
        ],
      },
    });

    // 2. Jika sudah ada, tolak dan kembalikan error Conflict (HTTP 409)
    if (existingSiswa) {
      throw new ConflictException('Gagal: NIS atau NISN sudah terdaftar di sistem.');
    }

    // 3. Jika aman, simpan ke database
    return this.prisma.siswa.create({
      data: createSiswaDto,
    });
  }

  async findAll() {
    // Ambil semua data siswa, urutkan dari yang terbaru ditambahkan
    return this.prisma.siswa.findMany({
      orderBy: { createdAt: 'desc' },
    });
  }
}