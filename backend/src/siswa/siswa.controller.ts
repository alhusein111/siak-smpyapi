import { Controller, Get, Post, Body, UsePipes, ValidationPipe } from '@nestjs/common';
import { SiswaService } from './siswa.service';
import { CreateSiswaDto } from './dto/create-siswa.dto';

@Controller('siswa') // Ini berarti semua endpoint berawalan http://localhost:3000/siswa
export class SiswaController {
  // Inject SiswaService agar bisa memanggil logika database
  constructor(private readonly siswaService: SiswaService) {}

  @Post()
  // UsePipes(new ValidationPipe(...)) akan otomatis mencegat request dan 
  // mencocokkannya dengan aturan di CreateSiswaDto sebelum masuk ke fungsi.
  @UsePipes(new ValidationPipe({ whitelist: true })) 
  async create(@Body() createSiswaDto: CreateSiswaDto) {
    return this.siswaService.create(createSiswaDto);
  }

  @Get()
  async findAll() {
    return this.siswaService.findAll();
  }
}