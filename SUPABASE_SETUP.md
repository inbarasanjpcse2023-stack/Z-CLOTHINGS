# Supabase Setup Guide for Z Clothing

This guide walks you through setting up your Supabase project for the Z Clothing backend.

## Step 1: Create a Supabase Project

1. Go to [supabase.com](https://supabase.com)
2. Sign in or create an account
3. Click **"New Project"**
4. Enter:
   - **Name**: `z-clothing` (or any name)
   - **Database Password**: Create a strong password
   - **Region**: Choose closest to your users
5. Click **Create new project** (wait ~2-3 minutes for it to provision)

## Step 2: Get Your Credentials

1. In your Supabase project dashboard, go to **Settings** → **API**
2. Copy these two values:
   - **Project URL** (under "Project URL")
   - **Service Role Key** (under "Service role key" - this has admin access)

3. Update your `.env` file:
   ```env
   SUPABASE_URL=https://your-project-ref.supabase.co
   SUPABASE_KEY=your-service-role-key-here
   ```

## Step 3: Create Database Tables

1. In your Supabase project dashboard, go to **SQL Editor**
2. Click **New Query**
3. Copy the entire contents of `SUPABASE_SCHEMA.sql` (in your project folder)
4. Paste it into the SQL Editor
5. Click **Run** (or press `Ctrl+Enter`)

You should see green checkmarks confirming all tables were created.

## Step 4: Verify Tables Created

1. Go to **Table Editor** in the left sidebar
2. You should see 4 tables:
   - `products`
   - `admin`
   - `users`
   - `orders`

## Step 5: Start Your Backend

```bash
npm start
```

Your backend should now:
- Start successfully on port 5003 (or next available)
- Show: `Using Supabase: configured`
- Auto-create an admin account (admin / admin123)

## Table Schemas Overview

### products
| Field | Type | Notes |
|-------|------|-------|
| id | BIGSERIAL | Auto-increment primary key |
| name | TEXT | Product name (required) |
| cat | TEXT | Category (required) |
| desc | TEXT | Description (optional) |
| price | NUMERIC | Price in rupees (required) |
| sizes | JSONB | Array of size objects: `[{size: "S", available: true}, ...]` |
| image | TEXT | Image URL (optional) |
| created_at | TIMESTAMP | Auto-set on creation |
| updated_at | TIMESTAMP | Auto-set on updates |

### admin
| Field | Type | Notes |
|-------|------|-------|
| id | BIGSERIAL | Auto-increment primary key |
| username | TEXT | Unique username (required) |
| password | TEXT | Bcrypt hashed password (required) |
| role | TEXT | Always 'admin' |
| created_at | TIMESTAMP | Auto-set on creation |

Default admin account created on first run:
- Username: `admin`
- Password: `admin123`

### users
| Field | Type | Notes |
|-------|------|-------|
| id | BIGSERIAL | Auto-increment primary key |
| name | TEXT | Customer name (required) |
| email | TEXT | Unique email (required) |
| password | TEXT | Bcrypt hashed password (required) |
| role | TEXT | Default 'customer' |
| createdAt | TIMESTAMP | Account creation time |
| updated_at | TIMESTAMP | Last update time |

### orders
| Field | Type | Notes |
|-------|------|-------|
| id | TEXT | Unique order ID like 'ZC123456' |
| date | TIMESTAMP | Order creation date |
| items | JSONB | Array of order items: `[{name: "shirt", size: "M", qty: 2, price: 500}, ...]` |
| customer | TEXT | Customer name |
| email | TEXT | Customer email |
| payment | TEXT | Payment method (e.g., 'card', 'upi') |
| address | TEXT | Shipping address |
| subtotal | NUMERIC | Subtotal before GST |
| gst | NUMERIC | GST amount (18%) |
| shipping | NUMERIC | Shipping cost (0 for free) |
| total | NUMERIC | Final total |
| status | TEXT | Order status (e.g., 'Pending', 'Shipped', 'Delivered') |
| created_at | TIMESTAMP | Order creation timestamp |

## Troubleshooting

### "Error: Supabase client is not configured"
- Make sure `SUPABASE_URL` and `SUPABASE_KEY` are set in `.env`
- Verify they're copied correctly with no extra spaces

### "PostgreSQL error: relation 'products' does not exist"
- Verify you ran the SQL schema in Step 3
- Check Table Editor to see if tables exist
- If missing, re-run the SQL statements

### "Admin login not working"
- First run should auto-create admin account
- Check `admin` table in Supabase Table Editor
- If empty, manually insert: `INSERT INTO admin (username, password, role) VALUES ('admin', '$2a$10$YOUR_BCRYPT_HASH', 'admin')`
  - Or restart the backend to trigger auto-seeding

### "CORS errors in frontend"
- CORS is already enabled in server.js
- Make sure your frontend is making requests to `http://localhost:5003`

## Example API Requests

### Admin Login
```bash
curl -X POST http://localhost:5003/api/admin/login \
  -H "Content-Type: application/json" \
  -d '{"username":"admin","password":"admin123"}'
```

### Get All Products
```bash
curl http://localhost:5003/api/products
```

### Create Product (requires admin token)
```bash
curl -X POST http://localhost:5003/api/products \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_ADMIN_TOKEN" \
  -d '{
    "name": "Blue Shirt",
    "cat": "shirts",
    "price": 500,
    "sizes": ["S", "M", "L", "XL"],
    "image": "https://example.com/shirt.jpg"
  }'
```

### Register Customer
```bash
curl -X POST http://localhost:5003/api/users/register \
  -H "Content-Type: application/json" \
  -d '{
    "name": "John Doe",
    "email": "john@example.com",
    "password": "securepass123"
  }'
```

### Place Order
```bash
curl -X POST http://localhost:5003/api/orders \
  -H "Content-Type: application/json" \
  -d '{
    "items": [{"name": "Blue Shirt", "size": "M", "qty": 1, "price": 500}],
    "customer": "John Doe",
    "email": "john@example.com",
    "payment": "card",
    "address": "123 Main St, City",
    "subtotal": 500,
    "gst": 90,
    "shipping": 50,
    "total": 640
  }'
```

## Next Steps

1. **Add sample products** via the `/api/products` endpoint or Supabase Table Editor
2. **Test the frontend** by opening `z-clothing.html` in your browser
3. **Configure email** in `.env` if you want order confirmation emails
4. **Deploy** to a cloud platform (Railway, Render, Fly.io, Heroku, etc.)

---

For more Supabase documentation, visit: https://supabase.com/docs
