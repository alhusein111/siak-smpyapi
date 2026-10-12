import { IsString, IsNotEmpty, IsIn } from 'class-validator';

export class CreateSiswaDto {
  @IsString({ message: 'NIS harus berupa teks' })
  @IsNotEmpty({ message: 'NIS tidak boleh kosong' })
  nis: string;

  @IsString({ message: 'NISN harus berupa teks' })
  @IsNotEmpty({ message: 'NISN tidak boleh kosong' })
  nisn: string;

  @IsString({ message: 'Nama siswa harus berupa teks' })
  @IsNotEmpty({ message: 'Nama siswa tidak boleh kosong' })
  nama: string;

  @IsString({ message: 'Kelas harus berupa teks' })
  @IsNotEmpty({ message: 'Kelas tidak boleh kosong' })
  kelas: string;

  @IsString()
  @IsNotEmpty({ message: 'Jenis kelamin tidak boleh kosong' })
  @IsIn(['L', 'P'], { message: 'Jenis kelamin harus L (Laki-laki) atau P (Perempuan)' })
  jenisKelamin: string;
}