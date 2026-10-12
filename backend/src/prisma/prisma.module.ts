import { Global, Module } from '@nestjs/common';
import { PrismaService } from './prisma.service';

@Global() // Menjadikan Prisma bisa diakses dari mana saja
@Module({
  providers: [PrismaService],
  exports: [PrismaService], // Mengekspor service agar bisa dipinjam modul lain
})
export class PrismaModule {}