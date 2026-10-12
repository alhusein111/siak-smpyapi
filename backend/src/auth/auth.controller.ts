import { Controller, Post, Body } from '@nestjs/common';
import { AuthService } from './auth.service';

@Controller('auth') // URL dasar: http://localhost:3000/auth
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  // Rute: POST http://localhost:3000/auth/register
  @Post('register')
  register(@Body() body: any) {
    return this.authService.register(body);
  }

  // Rute: POST http://localhost:3000/auth/login
  @Post('login')
  login(@Body() body: any) {
    return this.authService.login(body);
  }
}