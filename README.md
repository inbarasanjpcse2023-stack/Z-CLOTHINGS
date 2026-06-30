# 👕 Z Clothing – Wear The Edge

A modern and responsive fashion e-commerce website built using HTML, CSS, and JavaScript with Supabase integration for cloud database and image storage.

## 🚀 Features

### Customer Features
- Home page with featured products
- Product collections
- Category-wise filtering
- Product search
- Product details
- Shopping cart
- Quantity management
- Wishlist
- Checkout page
- Order confirmation
- Responsive design
- Smooth animations

### Admin Dashboard
- Secure admin login
- Add new products
- Edit existing products
- Delete products
- Product inventory management
- Image upload to Supabase Storage
- Product data stored in Supabase Database
- Sales dashboard
- Order management

### Database
- Supabase Database
- Supabase Storage for product images
- Public image URLs
- Cloud-based product management

---

## 🛠 Technologies Used

- HTML5
- CSS3
- JavaScript (ES6)
- Supabase
- Supabase Storage
- Local Storage
- Responsive Web Design

---

## 📂 Project Structure

```
Z-Clothing/
│
├── index.html
├── assets/
│   ├── images/
│   ├── icons/
│   └── styles/
├── README.md
└── screenshots/
```

---

## ⚙️ Setup

### 1. Clone Repository

```bash
git clone https://github.com/inbarasanjpcse2023-stack/z-clothing.git
```

### 2. Open Project

Open the project folder in Visual Studio Code.

### 3. Configure Supabase

Replace your project credentials.

```javascript
const supabaseUrl = "YOUR_SUPABASE_URL";
const supabaseKey = "YOUR_PUBLISHABLE_KEY";
```

### 4. Create Database

Create a table named:

```
products
```

Columns:

| Column | Type |
|---------|------|
| id | bigint |
| name | text |
| description | text |
| category | text |
| price | numeric |
| image_url | text |

### 5. Storage Bucket

Create a bucket named:

```
PRODUCT-IMAGES
```

Enable Public Access and create upload policy.

---

## Future Improvements

- User Authentication
- Payment Gateway Integration
- Order History
- Customer Accounts
- Product Reviews
- Ratings
- Coupons & Discounts
- Email Notifications
- Dark Mode

---

## Learning Outcomes

This project demonstrates:

- CRUD Operations
- Responsive Web Design
- JavaScript DOM Manipulation
- Local Storage
- Cloud Database Integration
- Image Upload & Storage
- REST API Integration
- Admin Dashboard Development

---

## Author

**Your Name**

GitHub: https://github.com/inbarasanjpcse2023-stack

LinkedIn: https://www.linkedin.com/in/inbarasan-jp

---

## License

This project is developed for educational and portfolio purposes.
