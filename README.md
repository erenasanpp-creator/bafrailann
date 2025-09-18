# Bafra İlan — Temiz Supabase Sürümü

## Kurulum
1. Supabase'te proje açın. **SQL Editor** → `supabase_schema.sql` dosyasını tamamen çalıştırın.
2. Supabase **Settings → API**'den
   - `NEXT_PUBLIC_SUPABASE_URL`
   - `NEXT_PUBLIC_SUPABASE_ANON_KEY`
   değerlerini alın.
3. Vercel'de yeni proje → bu repo → **Environment Variables**'a yukarıdaki 2 anahtarı koyun.
4. Deploy.

## Kullanım
- Üyelik: `/auth/register`
- Giriş: `/auth/login`
- İlan ver: `/jobs/new`
- Panel: `/dashboard` (admin için ekstra bloklar)

## Admin
- `lib/isAdmin.ts` içinde `ADMIN_EMAIL = "erenasanpp@gmail.com"` olarak ayarlı.
- Ayrıca `profiles.role='admin'` kullanıcılar da admin sayılır.
