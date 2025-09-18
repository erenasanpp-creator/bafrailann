-- Supabase SQL: tablolar ve RLS
create extension if not exists "pgcrypto";

create table if not exists profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  role text not null default 'candidate',
  approved boolean not null default false,
  owner_name text,
  business_name text,
  phone text,
  address text,
  logo_url text,
  created_at timestamptz not null default now()
);
alter table profiles enable row level security;
drop policy if exists "read profiles" on profiles;
create policy "read profiles" on profiles for select using (true);
drop policy if exists "update own profile" on profiles;
create policy "update own profile" on profiles for update using (auth.uid() = id);

create table if not exists jobs (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  store_name text not null,
  position text not null,
  work_hours text,
  description text,
  requirements text,
  benefits text,
  location text default 'Bafra',
  experience_level text,
  education_level text,
  salary_min numeric,
  salary_max numeric,
  application_email text,
  application_phone text,
  application_link text,
  employment_type text default 'Tam Zamanlı',
  logo_url text,
  active boolean not null default true,
  created_at timestamptz not null default now()
);
alter table jobs enable row level security;
drop policy if exists "public read jobs" on jobs;
create policy "public read jobs" on jobs for select using (active = true);
drop policy if exists "owner insert job" on jobs;
create policy "owner insert job" on jobs for insert with check (auth.uid() = user_id);
drop policy if exists "owner modify job" on jobs;
create policy "owner modify job" on jobs for update using (auth.uid() = user_id);
drop policy if exists "owner delete job" on jobs;
create policy "owner delete job" on jobs for delete using (auth.uid() = user_id);

create table if not exists applications (
  id uuid primary key default gen_random_uuid(),
  job_id uuid not null references jobs(id) on delete cascade,
  job_owner_id uuid not null references auth.users(id) on delete cascade,
  candidate_id uuid not null references auth.users(id) on delete cascade,
  candidate_name text,
  candidate_email text,
  candidate_phone text,
  experience text,
  cv_url text,
  created_at timestamptz not null default now()
);
alter table applications enable row level security;
drop policy if exists "read own apps" on applications;
create policy "read own apps" on applications for select using (auth.uid() = candidate_id or auth.uid() = job_owner_id);
drop policy if exists "insert own app" on applications;
create policy "insert own app" on applications for insert with check (auth.uid() = candidate_id);
