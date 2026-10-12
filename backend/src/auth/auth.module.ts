import { Module } from '@nestjs/common';
import { JwtModule } from '@nestjs/jwt'; // Import JWT
import { AuthService } from './auth.service';
import { AuthController } from './auth.controller';

@Module({
  imports: [
    // Mendaftarkan mesin pembuat tiket (JWT)
    JwtModule.register({
      global: true, // Tiket ini bisa dicek dari seluruh penjuru aplikasi
      secret: process.env.JWT_SECRET, // Mengambil kata sandi dari file .env
      signOptions: { expiresIn: '1d' }, // Tiket hangus (logout otomatis) dalam 1 hari
    }),
  ],
  providers: [AuthService],
  controllers: [AuthController]
})
export class AuthModule {}