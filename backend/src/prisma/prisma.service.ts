import { Injectable, OnModuleInit } from '@nestjs/common';
import { PrismaClient } from '@prisma/client';

@Injectable()
export class PrismaService extends PrismaClient implements OnModuleInit {
  // Fungsi ini otomatis berjalan saat backend dinyalakan
  async onModuleInit() {
    await this.$connect(); // Membuka koneksi ke database PostgreSQL
  }
}