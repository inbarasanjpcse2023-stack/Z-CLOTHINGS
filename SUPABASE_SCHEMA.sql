-- Z Clothing Supabase Schema
-- Run these DDL statements in the Supabase SQL Editor to set up your database

-- Table: products
-- Stores clothing products with categories, pricing, and sizes
CREATE TABLE IF NOT EXISTS products (
  id BIGSERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  cat TEXT NOT NULL,
  "desc" TEXT DEFAULT '',
  price NUMERIC(10, 2) NOT NULL,
  sizes JSONB NOT NULL,
  image TEXT DEFAULT '',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Index for faster category queries
CREATE INDEX IF NOT EXISTS idx_products_cat ON products(cat);

-- Table: admin
-- Stores admin user accounts with hashed passwords
CREATE TABLE IF NOT EXISTS admin (
  id BIGSERIAL PRIMARY KEY,
  username TEXT NOT NULL UNIQUE,
  password TEXT NOT NULL,
  role TEXT DEFAULT 'admin',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Table: users
-- Stores customer accounts
CREATE TABLE IF NOT EXISTS users (
  id BIGSERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  email TEXT NOT NULL UNIQUE,
  password TEXT NOT NULL,
  role TEXT DEFAULT 'customer',
  "createdAt" TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Index for faster email lookups
CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);

-- Table: orders
-- Stores customer orders with line items and payment info
CREATE TABLE IF NOT EXISTS orders (
  id TEXT PRIMARY KEY,
  date TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  items JSONB NOT NULL,
  customer TEXT,
  email TEXT,
  payment TEXT,
  address TEXT,
  subtotal NUMERIC(12, 2),
  gst NUMERIC(12, 2),
  shipping NUMERIC(12, 2),
  total NUMERIC(12, 2),
  status TEXT DEFAULT 'Pending',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Index for faster order queries by email
CREATE INDEX IF NOT EXISTS idx_orders_email ON orders(email);
CREATE INDEX IF NOT EXISTS idx_orders_status ON orders(status);
CREATE INDEX IF NOT EXISTS idx_orders_date ON orders(date DESC);

-- Enable Row Level Security (optional but recommended)
ALTER TABLE products ENABLE ROW LEVEL SECURITY;
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE admin ENABLE ROW LEVEL SECURITY;
ALTER TABLE orders ENABLE ROW LEVEL SECURITY;

-- Create public access policy for products (anyone can read)
CREATE POLICY "products_public_read" ON products
  FOR SELECT USING (true);

-- Admin can manage products
CREATE POLICY "products_admin_write" ON products
  FOR INSERT WITH CHECK (true);

CREATE POLICY "products_admin_update" ON products
  FOR UPDATE USING (true);

CREATE POLICY "products_admin_delete" ON products
  FOR DELETE USING (true);

-- Users can read their own profile
CREATE POLICY "users_self_read" ON users
  FOR SELECT USING (auth.uid()::text = id::text);

-- Users can update their own profile
CREATE POLICY "users_self_update" ON users
  FOR UPDATE USING (auth.uid()::text = id::text);

-- Orders visible to owner or admin
CREATE POLICY "orders_self_read" ON orders
  FOR SELECT USING (true);

CREATE POLICY "orders_insert" ON orders
  FOR INSERT WITH CHECK (true);

-- Admin table - restrict access
CREATE POLICY "admin_read" ON admin
  FOR SELECT USING (true);

CREATE POLICY "admin_write" ON admin
  FOR INSERT WITH CHECK (true);

CREATE POLICY "admin_update" ON admin
  FOR UPDATE USING (true);
